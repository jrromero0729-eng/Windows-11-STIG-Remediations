<#
.SYNOPSIS
    Verification script for DISA STIG WN11-AC-000010 (V-253298).
    Confirms the account lockout threshold is set to 10 or fewer invalid logon attempts.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-AC-000010)

.TESTED ON
    Date(s) Tested  : 2025-12-27
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

Write-Host "=== Verification: WN11-AC-000010 - Account Lockout Threshold ==="

$maxAllowedThreshold = 10

try {
    $output = (cmd /c "net accounts") -join "`n"
    $policyLine = $output | Select-String -Pattern "Lockout threshold" -SimpleMatch

    if (-not $policyLine) {
        Write-Host "FAIL: Could not locate account lockout threshold policy."
        exit 1
    }

    Write-Host "Current policy:"
    Write-Host $policyLine

    $currentValue = [int](([string]$policyLine).Split(':')[-1].Trim())

    if ($currentValue -le $maxAllowedThreshold -and $currentValue -gt 0) {
        Write-Host "PASS: Account lockout threshold is $currentValue (compliant)."
        exit 0
    } else {
        Write-Host "FAIL: Account lockout threshold is $currentValue (expected 1–$maxAllowedThreshold)."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
