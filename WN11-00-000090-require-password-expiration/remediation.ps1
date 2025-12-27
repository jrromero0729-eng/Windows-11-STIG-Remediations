<#
.SYNOPSIS
    DISA STIG WN11-00-000090 requires accounts to be configured to require password expiration.
    This remediation ensures local user accounts are not configured with "Password never expires".

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
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000090-require-password-expiration
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

Write-Host "=== Remediation: WN11-00-000090 - Require Password Expiration (Local Accounts) ==="

try {
    # Get local users and exclude built-in/system accounts that may not be applicable
    $excluded = @("Administrator", "Guest", "DefaultAccount", "WDAGUtilityAccount")
    $users = Get-LocalUser | Where-Object { $excluded -notcontains $_.Name }

    if (-not $users) {
        Write-Host "No local user accounts found to remediate (excluding built-ins)."
        exit 0
    }

    $changed = 0

    foreach ($u in $users) {
        # Only remediate enabled accounts (optional - safer)
        if ($u.Enabled -eq $true -and $u.PasswordNeverExpires -eq $true) {
            Write-Host "Updating user '$($u.Name)': setting PasswordNeverExpires = False"
            Set-LocalUser -Name $u.Name -PasswordNeverExpires $false
            $changed++
        } else {
            Write-Host "User '$($u.Name)' already compliant or not applicable."
        }
    }

    # Post-check
    $nonCompliant = Get-LocalUser |
        Where-Object { $excluded -notcontains $_.Name } |
        Where-Object { $_.Enabled -eq $true -and $_.PasswordNeverExpires -eq $true }

    if ($nonCompliant) {
        Write-Error "FAILURE: Some local accounts still have PasswordNeverExpires enabled:"
        $nonCompliant | Select-Object Name, Enabled, PasswordNeverExpires | Format-Table -AutoSize
        exit 2
    }

    Write-Host "SUCCESS: Local accounts are configured to require password expiration."
    Write-Host "Accounts updated: $changed"
    exit 0
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
