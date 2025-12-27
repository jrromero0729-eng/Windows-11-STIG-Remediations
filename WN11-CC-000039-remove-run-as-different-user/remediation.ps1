<#
.SYNOPSIS
    DISA STIG WN11-CC-000039 (V-253336) requires the "Run as different user"
    option to be removed from Windows context menus.
    This remediation enforces the setting using the corresponding policy-based
    registry configuration evaluated by Tenable.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-CC-000039)

    This policy is normally configured using the MS Security Guide ADMX templates
    (SecGuide.admx/adml). This script directly configures the effective registry
    setting used by the policy.

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-CC-000039-remove-run-as-different-user
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

Write-Host "=== Remediation: WN11-CC-000039 - Remove 'Run as different user' ==="

# Policy registry location
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
$regName = "DisableRunAsDifferentUser"
$desiredValue = 1

try {
    # Ensure registry path exists
    New-Item -Path $regPath -Force | Out-Null

    # Set policy value
    New-ItemProperty -Path $regPath -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null

    # Verify configuration
    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    Write-Host "Configured $regPath\$regName = $currentValue"

    if ($currentValue -eq $desiredValue) {
        Write-Host "SUCCESS: 'Run as different user' has been removed from context menus."
        Write-Host "NOTE: A sign-out or reboot may be required for UI changes to take effect."
        exit 0
    } else {
        Write-Error "FAILURE: Registry value does not match the expected configuration."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
