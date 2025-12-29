<#
.SYNOPSIS
    DISA STIG WN11-AC-000010 requires the number of allowed bad logon attempts
    (Account lockout threshold) to be configured to three or less.
    This verification checks the current Account lockout threshold value.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-10-31
    Last Modified   : 2025-12-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-AC-000010)

.TESTED ON
    Date(s) Tested  : 2025-11-01, 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-AC-000010-account-lockout-threshold
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-AC-000010 - Account Lockout Threshold (<= 3) ==="

try {
    $output = net accounts
    $line = $output | Select-String -Pattern "Lockout threshold" -ErrorAction Stop

    $currentValue = [int]([regex]::Match($line.Line, "\d+").Value)

    Write-Host "Current lockout threshold: $currentValue"
    Write-Host "Expected: 1 to 3 (0 is NOT acceptable)"

    if ($currentValue -ge 1 -and $currentValue -le 3) {
        Write-Host "PASS: Account lockout threshold meets STIG requirements."
        exit 0
    } else {
        Write-Host "FAIL: Account lockout threshold does not meet STIG requirements."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
