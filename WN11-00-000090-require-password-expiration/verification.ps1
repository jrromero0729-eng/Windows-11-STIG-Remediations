<#
.SYNOPSIS
    Verification script for DISA STIG WN11-00-000090.
    Confirms local enabled user accounts do not have "Password never expires" enabled (no changes are made).

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000090)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000090-require-password-expiration
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-00-000090 - Require Password Expiration (Local Accounts) ==="

try {
    $excluded = @("Administrator", "Guest", "DefaultAccount", "WDAGUtilityAccount")

    $nonCompliant = Get-LocalUser |
        Where-Object { $excluded -notcontains $_.Name } |
        Where-Object { $_.Enabled -eq $true -and $_.PasswordNeverExpires -eq $true }

    if ($nonCompliant) {
        Write-Host "FAIL: The following local accounts have PasswordNeverExpires enabled:"
        $nonCompliant | Select-Object Name, Enabled, PasswordNeverExpires | Format-Table -AutoSize
        exit 1
    }

    Write-Host "PASS: No enabled local accounts have PasswordNeverExpires enabled."
    exit 0
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
