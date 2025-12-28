<#
.SYNOPSIS
    DISA STIG WN11-00-000135 requires a host-based firewall to be installed
    and enabled on the system. This remediation ensures Windows Defender
    Firewall is enabled for all network profiles.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000135)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000135-enable-firewall
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

Write-Host "=== Remediation: WN11-00-000135 - Enable Windows Defender Firewall ==="

try {
    # Enable firewall for all profiles
    $profiles = @("Domain", "Private", "Public")

    foreach ($profile in $profiles) {
        Write-Host "Enabling Windows Defender Firewall for $profile profile..."
        Set-NetFirewallProfile -Profile $profile -Enabled True
    }

    Write-Host "SUCCESS: Windows Defender Firewall enabled for all profiles."
    Write-Host "NOTE: Group Policy refresh or reboot may be required for audit validation."
    exit 0
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
