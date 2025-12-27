<#
.SYNOPSIS
    Verification script for DISA STIG WN11-CC-000315.
    Confirms the Windows Installer policy "Always install with elevated privileges" is disabled
    by checking both machine and user policy registry settings.

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
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-CC-000315-disable-always-install-elevated
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-CC-000315 - Disable 'Always install with elevated privileges' ==="

$machineRegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$userRegPath    = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$regName        = "AlwaysInstallElevated"
$expectedValue  = 0

try {
    if (-not (Test-Path $machineRegPath)) {
        Write-Host "FAIL: Registry path not found: $machineRegPath"
        exit 1
    }

    if (-not (Test-Path $userRegPath)) {
        Write-Host "FAIL: Registry path not found: $userRegPath"
        exit 1
    }

    $currentMachine = (Get-ItemProperty -Path $machineRegPath -Name $regName -ErrorAction Stop).$regName
    $currentUser    = (Get-ItemProperty -Path $userRegPath    -Name $regName -ErrorAction Stop).$regName

    Write-Host "Found $machineRegPath\$regName = $currentMachine"
    Write-Host "Found $userRegPath\$regName    = $currentUser"

    if ($currentMachine -eq $expectedValue -and $currentUser -eq $expectedValue) {
        Write-Host "PASS: 'Always install with elevated privileges' is disabled for both machine and user policy."
        exit 0
    } else {
        Write-Host "FAIL: Expected $regName = $expectedValue for both machine and user policy."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
