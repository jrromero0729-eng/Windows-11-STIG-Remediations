<#
.SYNOPSIS
    DISA STIG WN11-00-000170 requires the SMBv1 protocol to be disabled
    on the SMB client. This remediation disables the SMBv1 client
    driver by configuring the required registry setting.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000170)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000170-disable-smbv1-client
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

Write-Host "=== Remediation: WN11-00-000170 - Disable SMBv1 Client ==="

try {
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10"
    $regName = "Start"
    $desiredValue = 4   # Disabled

    # Ensure registry path exists
    if (-not (Test-Path $regPath)) {
        Write-Error "SMBv1 client driver registry path not found."
        exit 2
    }

    # Set registry value
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue

    # Verify configuration
    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
    Write-Host "Configured $regPath\$regName = $currentValue"

    if ($currentValue -eq $desiredValue) {
        Write-Host "SUCCESS: SMBv1 client protocol has been disabled."
        Write-Host "NOTE: A system reboot is required for this change to take effect."
        exit 0
    }
    else {
        Write-Error "FAILURE: SMBv1 client registry value does not match expected configuration."
        exit 3
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 4
}
