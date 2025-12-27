<#
.SYNOPSIS
    Verification script for DISA STIG WN11-AC-000005 (V-253297).
    Confirms the account lockout duration meets or exceeds 15 minutes.

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

Write-Host "=== Verification: WN11-AC-000005 - Account Lockout Duration ==="

$expectedDuration = 15

try {
    $output = (cmd /c "net accounts") -join "`n"
    $policyLine = $output | Select-String -Pattern "Lockout duration" -SimpleMatch

    if (-not $policyLine) {
        Write-Host "FAIL: Could not locate account lockout duration policy."
        exit 1
    }

    Write-Host "Current policy:"
    Write-Host $policyLine

    # Extract numeric value
    $currentValue = [int](([string]$policyLine).Split(':')[-1].Trim())

    if ($currentValue -ge $expectedDuration) {
        Write-Host "PASS: Account lockout duration is $currentValue minutes (meets/exceeds $expectedDuration)."
        exit 0
    } else {
        Write-Host "FAIL: Account lockout duration is $currentValue minutes (expected >= $expectedDuration)."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
