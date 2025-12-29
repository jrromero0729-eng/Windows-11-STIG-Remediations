<#
.SYNOPSIS
    DISA STIG WN11-CC-000315 requires the Windows Installer feature
    'Always install with elevated privileges' to be disabled.
    This remediation enforces the setting by configuring the required
    policy-based registry values.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-12
    Last Modified   : 2025-12-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-CC-000315)

.TESTED ON
    Date(s) Tested  : 2025-12-13, 2025-12-28
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-CC-000315-disable-alwaysinstall-elevated
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

Write-Host "=== Remediation: WN11-CC-000315 - Disable Always Install with Elevated Privileges ==="

try {
    $desiredValue = 0

    # Computer policy path (HKLM)
    $regPathHKLM = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
    $regName = "AlwaysInstallElevated"

    # User policy path (HKCU) - included for defense-in-depth and audit consistency
    $regPathHKCU = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer"

    # Ensure registry paths exist
    New-Item -Path $regPathHKLM -Force | Out-Null
    New-Item -Path $regPathHKCU -Force | Out-Null

    # Set policy values to Disabled (0)
    New-ItemProperty -Path $regPathHKLM -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null
    New-ItemProperty -Path $regPathHKCU -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null

    # Verify configuration
    $currentHKLM = (Get-ItemProperty -Path $regPathHKLM -Name $regName -ErrorAction Stop).$regName
    $currentHKCU = (Get-ItemProperty -Path $regPathHKCU -Name $regName -ErrorAction Stop).$regName

    Write-Host "Configured $regPathHKLM\$regName = $currentHKLM"
    Write-Host "Configured $regPathHKCU\$regName = $currentHKCU"

    if ($currentHKLM -eq $desiredValue -and $currentHKCU -eq $desiredValue) {
        Write-Host "SUCCESS: 'Always install with elevated privileges' is disabled (policy value = 0)."
        Write-Host "NOTE: A reboot or Group Policy refresh may be required for audit validation."
        exit 0
    }
    else {
        Write-Error "FAILURE: One or more registry values do not match the expected configuration (0)."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
