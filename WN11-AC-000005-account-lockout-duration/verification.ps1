<#
.SYNOPSIS
    DISA STIG WN11-AC-000005 requires the Windows 11 account lockout duration to be configured to 15 minutes or greater.
    This verification checks the local Account Lockout Policy "Account lockout duration" is >= 15 minutes or equals 0.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-AC-000005)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-AC-000005-account-lockout-duration
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-AC-000005 - Account Lockout Duration (>= 15 minutes) ==="

try {
    $output = net accounts
    $line = $output | Select-String -Pattern "Lockout duration" -ErrorAction Stop

    # Extract the first number from the line (minutes)
    $minutes = [int]([regex]::Match($line.Line, "\d+").Value)

    Write-Host "Current lockout duration (minutes): $minutes"
    Write-Host "Expected: >= 15 minutes OR 0 (admin unlock required)"

    if ($minutes -ge 15 -or $minutes -eq 0) {
        Write-Host "PASS: Account lockout duration meets STIG requirements."
        exit 0
    } else {
        Write-Host "FAIL: Account lockout duration does not meet STIG requirements."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
