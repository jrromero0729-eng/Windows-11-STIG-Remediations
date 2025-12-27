<#
.SYNOPSIS
    DISA STIG WN11-CC-000315 requires the Windows Installer feature "Always install with elevated privileges" to be disabled.
    This remediation disables the policy by configuring both machine and user policy registry settings.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-CC-000315)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-CC-000315-disable-always-install-elevated
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

Write-Host "=== Remediation: WN11-CC-000315 - Disable 'Always install with elevated privileges' ==="

# Policy registry paths
$machineRegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$userRegPath    = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$regName        = "AlwaysInstallElevated"
$desiredValue   = 0

try {
    # Ensure registry paths exist
    New-Item -Path $machineRegPath -Force | Out-Null
    New-Item -Path $userRegPath -Force | Out-Null

    # Set policy values (0 = Disabled)
    New-ItemProperty -Path $machineRegPath -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null
    New-ItemProperty -Path $userRegPath    -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null

    # Verify configuration
    $currentMachine = (Get-ItemProperty -Path $machineRegPath -Name $regName -ErrorAction Stop).$regName
    $currentUser    = (Get-ItemProperty -Path $userRegPath    -Name $regName -ErrorAction Stop).$regName

    Write-Host "Configured $machineRegPath\$regName = $currentMachine"
    Write-Host "Configured $userRegPath\$regName    = $currentUser"

    if ($currentMachine -eq $desiredValue -and $currentUser -eq $desiredValue) {
        Write-Host "SUCCESS: 'Always install with elevated privileges' is disabled for both machine and user policy."
        exit 0
    } else {
        Write-Error "FAILURE: One or more registry values do not match the expected configuration."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
