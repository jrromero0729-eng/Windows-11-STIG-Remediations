<#
.SYNOPSIS
    DISA STIG WN11-00-000170 requires AutoPlay to be disabled.
    This remediation disables AutoPlay using policy-based registry settings.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000170)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000170-disable-autoplay
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

Write-Host "=== Remediation: WN11-00-000170 - Disable AutoPlay ==="

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$regName = "NoDriveTypeAutoRun"
$desiredValue = 255

try {
    New-Item -Path $regPath -Force | Out-Null

    # Disable AutoRun/AutoPlay on all drive types (255)
    New-ItemProperty -Path $regPath -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null

    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    Write-Host "Configured $regPath\$regName = $currentValue"

    if ($currentValue -eq $desiredValue) {
        Write-Host "SUCCESS: AutoPlay/AutoRun is disabled (NoDriveTypeAutoRun=$desiredValue)."
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
