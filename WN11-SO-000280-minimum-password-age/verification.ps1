<#
.SYNOPSIS
    Verifies DISA STIG WN11-SO-000280 compliance by confirming Windows LAPS
    is enabled and configured to rotate the local Administrator password
    at least every 60 days.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-SO-000280)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-SO-000280-enable-laps
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-SO-000280 - Windows LAPS Password Rotation ==="

try {
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LAPS"

    if (-not (Test-Path $regPath)) {
        Write-Host "FAIL: LAPS policy registry path not found."
        exit 1
    }

    $config = Get-ItemProperty -Path $regPath

    $enabled     = $config.BackupDirectory -eq 1
    $ageValid    = $config.PasswordAgeDays -le 60
    $adminTarget = $config.AdministratorAccountName -eq "Administrator"

    Write-Host "BackupDirectory          = $($config.BackupDirectory)"
    Write-Host "PasswordAgeDays          = $($config.PasswordAgeDays)"
    Write-Host "AdministratorAccountName = $($config.AdministratorAccountName)"

    if ($enabled -and $ageValid -and $adminTarget) {
        Write-Host "PASS: Windows LAPS is correctly configured for Administrator password rotation."
        exit 0
    }
    else {
        Write-Host "FAIL: One or more LAPS settings do not meet STIG requirements."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
