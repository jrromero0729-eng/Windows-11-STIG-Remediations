<#
.SYNOPSIS
    DISA STIG WN11-CC-000039 requires 'Run as different user' to be removed from context menus.
    This remediation enforces the policy by configuring the registry-based policy setting to hide
    the "Run as different user" option.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-11-14
    Last Modified   : 2025-12-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-CC-000039)

.TESTED ON
    Date(s) Tested  : 2025-11-15, 2025-12-28
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

Write-Host "=== Remediation: WN11-CC-000039 - Remove 'Run as different user' from context menus ==="

try {
    # Policy-based registry configuration
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
    $regName = "ShowRunAsDifferentUserInStart"

    # Setting to 0 hides/removes "Run as different user" from context menus
    $desiredValue = 0

    # Ensure registry path exists
    New-Item -Path $regPath -Force | Out-Null

    # Set policy value
    New-ItemProperty -Path $regPath -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null

    # Verify configuration
    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    Write-Host "Configured $regPath\$regName = $currentValue"

    if ($currentValue -eq $desiredValue) {
        Write-Host "SUCCESS: 'Run as different user' has been removed (policy enforced)."
        Write-Host "NOTE: A reboot or 'gpupdate /force' may be required for full UI/audit validation."
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
