<#
.SYNOPSIS
    DISA STIG WN11-00-000125 requires Windows Copilot to be disabled.
    This remediation enforces the policy setting by configuring the appropriate HKLM policy registry key.

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

# Policy-based registry location for Windows Copilot
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"
$regName = "TurnOffWindowsCopilot"
$desiredValue = 1

try {
    # Ensure key exists
    New-Item -Path $regPath -Force | Out-Null

    # Set policy value
    New-ItemProperty -Path $regPath -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null

    # Verify after setting
    $current = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName

    Write-Host "Configured $regPath\$regName = $current"

    if ($current -eq $desiredValue) {
        Write-Host "SUCCESS: Windows Copilot policy is set to disabled."
        Write-Host "NOTE: You may need to sign out/in or reboot for UI changes. If Tenable still fails, reboot and re-scan."
        exit 0
    } else {
        Write-Error "FAILURE: Registry value did not match expected state."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
