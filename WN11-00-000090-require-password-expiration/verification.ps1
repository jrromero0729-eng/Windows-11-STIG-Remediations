<#
.SYNOPSIS
    DISA STIG WN11-00-000090 requires accounts to be configured to require password expiration.
    This verification checks that enabled local user accounts are not configured with "Password never expires".

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-09-19
    Last Modified   : 2025-12-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000090)

.TESTED ON
    Date(s) Tested  : 2025-09-20, 2025-12-26
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
    # Exclude only built-in/system accounts that are typically not applicable
    # NOTE: Administrator is intentionally NOT excluded for best chance of first-pass Tenable compliance.
    $excluded = @("Guest", "DefaultAccount", "WDAGUtilityAccount")

    # Get enabled local users (active accounts) excluding the above
    $users = Get-LocalUser -ErrorAction Stop | Where-Object {
        $_.Enabled -eq $true -and ($excluded -notcontains $_.Name)
    }

    if (-not $users) {
        Write-Host "PASS: No enabled local user accounts found to evaluate (excluding system accounts)."
        exit 0
    }

    Write-Host "Accounts evaluated (enabled only):"
    $users | Select-Object Name, Enabled, PasswordNeverExpires | Format-Table -AutoSize

    $nonCompliant = $users | Where-Object { $_.PasswordNeverExpires -eq $true }

    if ($nonCompliant) {
        Write-Host "FAIL: The following enabled local accounts have 'Password never expires' enabled:"
        $nonCompliant | Select-Object Name, Enabled, PasswordNeverExpires | Format-Table -AutoSize
        exit 1
    }

    Write-Host "PASS: All enabled local accounts require password expiration."
    exit 0
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
