<#
.SYNOPSIS
    Verification script for DISA STIG WN11-AC-000035 (V-253303).
    Confirms the local minimum password length meets or exceeds 14 characters.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-AC-000035)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-AC-000035-minimum-password-length
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-AC-000035 - Minimum Password Length ==="

$expectedMinLength = 14

try {
    $output = (cmd /c "net accounts") -join "`n"
    $policyLine = $output | Select-String -Pattern "Minimum password length" -SimpleMatch

    if (-not $policyLine) {
        Write-Host "FAIL: Could not locate minimum password length policy."
        exit 1
    }

    Write-Host "Current policy:"
    Write-Host $policyLine

    $currentValue = [int](([string]$policyLine).Split(':')[-1].Trim())

    if ($currentValue -ge $expectedMinLength) {
        Write-Host "PASS: Minimum password length is $currentValue (meets/exceeds $expectedMinLength)."
        exit 0
    } else {
        Write-Host "FAIL: Minimum password length is $currentValue (expected >= $expectedMinLength)."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
