<#
.SYNOPSIS
    Verification script for the Windows 11 STIG minimum password length requirement.
    Confirms the local "Minimum password length" value meets or exceeds the expected setting.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit - Minimum Password Length)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-SO-min-password-length
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: Windows 11 STIG - Minimum Password Length ==="

# Expected minimum password length
$expectedMinLength = 14

try {
    $output = (cmd /c "net accounts") -join "`n"
    $line = $output | Select-String -Pattern "Minimum password length" -SimpleMatch

    if (-not $line) {
        Write-Host "FAIL: Could not locate the 'Minimum password length' line in net accounts output."
        exit 1
    }

    Write-Host "Policy line:"
    Write-Host $line

    # Extract digits from the line
    $value = [int](([string]$line).Split(':')[-1].Trim())

    if ($value -ge $expectedMinLength) {
        Write-Host "PASS: Minimum password length is $value (meets/exceeds $expectedMinLength)."
        exit 0
    } else {
        Write-Host "FAIL: Minimum password length is $value (expected >= $expectedMinLength)."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
