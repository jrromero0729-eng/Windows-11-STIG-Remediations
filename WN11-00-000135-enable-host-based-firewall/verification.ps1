<#
.SYNOPSIS
    Verifies DISA STIG WN11-00-000135 compliance by confirming Windows Defender
    Firewall is enabled for all network profiles.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-10-03
    Last Modified   : 2025-12-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000135)

.TESTED ON
    Date(s) Tested  : 2025-10-04, 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000135-enable-firewall
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-00-000135 - Windows Defender Firewall Status ==="

try {
    $profiles = Get-NetFirewallProfile
    $nonCompliant = @()

    foreach ($profile in $profiles) {
        Write-Host "$($profile.Name) Profile - Enabled: $($profile.Enabled)"
        if ($profile.Enabled -ne $true) {
            $nonCompliant += $profile.Name
        }
    }

    if ($nonCompliant.Count -gt 0) {
        Write-Host "FAIL: Firewall is disabled for the following profile(s): $($nonCompliant -join ', ')"
        exit 1
    }

    Write-Host "PASS: Windows Defender Firewall is enabled for all profiles."
    exit 0
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
