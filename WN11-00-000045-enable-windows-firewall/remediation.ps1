<#
.SYNOPSIS
    DISA STIG WN11-00-000045 requires Windows Defender Firewall to be enabled.
    This remediation enables the firewall for Domain, Private, and Public profiles
    using policy-based registry settings.

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
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000045-enable-windows-firewall
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

Write-Host "=== Remediation: WN11-00-000045 - Enable Windows Defender Firewall ==="

$profiles = @(
    "DomainProfile",
    "PrivateProfile",
    "PublicProfile"
)

try {
    foreach ($profile in $profiles) {
        Write-Host "Enabling Firewall for $profile..."
        Set-NetFirewallProfile -Profile $profile -Enabled True
    }

    # Verification after remediation
    $status = Get-NetFirewallProfile |
        Select-Object Name, Enabled

    Write-Host "`nCurrent Firewall Profile Status:"
    $status | Format-Table -AutoSize

    if ($status.Enabled -contains $false) {
        Write-Error "FAILURE: One or more firewall profiles are still disabled."
        exit 2
    }

    Write-Host "SUCCESS: Windows Defender Firewall is enabled for all profiles."
    exit 0
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
