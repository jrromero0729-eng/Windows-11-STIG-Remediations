<#
.SYNOPSIS
    DISA STIG WN11-00-000125 requires Copilot in Windows to be disabled for Windows 11.
    This remediation enforces the policy "Turn off Windows Copilot" by setting the required policy registry value.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000125)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000125-disable-windows-copilot
    3. Run the script:
         .\remediation.ps1

    Example syntax:
        PS C:\> .\remediation.ps1
#>

# -------------------------
# Main Script
# -------------------------

# Admin check
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Run this script as Administrator."
    exit 1
}

Write-Host "=== Remediation: WN11-00-000125 - Disable Windows Copilot ==="

try {
    # Policy value expected by Tenable (Enabled = 1)
    $regName = "TurnOffWindowsCopilot"
    $desiredValue = 1

    # User policy path (matches User Configuration)
    $hkcuPath = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"
    # Machine policy path (covers Tenable implementations that evaluate HKLM)
    $hklmPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"

    # Ensure registry paths exist
    New-Item -Path $hkcuPath -Force | Out-Null
    New-Item -Path $hklmPath -Force | Out-Null

    # Set policy values
    New-ItemProperty -Path $hkcuPath -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null
    New-ItemProperty -Path $hklmPath -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null

    # Verify configuration
    $currentHKCU = (Get-ItemProperty -Path $hkcuPath -Name $regName -ErrorAction Stop).$regName
    $currentHKLM = (Get-ItemProperty -Path $hklmPath -Name $regName -ErrorAction Stop).$regName

    Write-Host "Configured $hkcuPath\$regName = $currentHKCU"
    Write-Host "Configured $hklmPath\$regName = $currentHKLM"

    if ($currentHKCU -eq $desiredValue -and $currentHKLM -eq $desiredValue) {
        Write-Host "SUCCESS: Windows Copilot is disabled via policy (TurnOffWindowsCopilot = 1)."
        Write-Host "NOTE: A sign-out/sign-in or reboot may be required for the UI to reflect changes and for audit validation."
        exit 0
    } else {
        Write-Error "FAILURE: One or more registry values do not match the expected configuration."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
