<#
.SYNOPSIS
    Verification script for DISA STIG WN11-00-000045.
    Confirms Windows Defender Firewall is enabled for Domain, Private, and Public profiles.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000045)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000045-enable-windows-firewall
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-00-000045 - Windows Defender Firewall Enabled ==="

try {
    $profiles = Get-NetFirewallProfile |
        Select-Object Name, Enabled

    $profiles | Format-Table -AutoSize

    if ($profiles.Enabled -contains $false) {
        Write-Host "FAIL: One or more firewall profiles are disabled."
        exit 1
    }

    Write-Host "PASS: Windows Defender Firewall is enabled for all profiles."
    exit 0
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
