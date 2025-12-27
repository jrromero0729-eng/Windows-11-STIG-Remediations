<#
.SYNOPSIS
    DISA STIG WN11-00-000135 requires BitLocker protection to be enforced for removable data drives.
    This remediation configures policy to require encryption before granting write access to removable drives.

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
         cd C:\path\to\WN11-00-000135-bitlocker-removable-drives
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

Write-Host "=== Remediation: WN11-00-000135 - BitLocker Removable Data Drives Policy ==="

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"
$regName = "RDVRequireEncryptionForWriteAccess"
$desiredValue = 1

try {
    New-Item -Path $regPath -Force | Out-Null

    # Require BitLocker encryption for removable drives before write access
    New-ItemProperty -Path $regPath -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null

    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    Write-Host "Configured $regPath\$regName = $currentValue"

    if ($currentValue -eq $desiredValue) {
        Write-Host "SUCCESS: Removable data drives require BitLocker encryption for write access."
        Write-Host "NOTE: This enforces policy; existing removable drives may require encryption to comply."
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
