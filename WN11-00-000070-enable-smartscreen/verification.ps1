<#
.SYNOPSIS
    Verification script for DISA STIG WN11-00-000070.
    Confirms Microsoft Defender SmartScreen is enabled via policy configuration.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000070)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000070-enable-smartscreen
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-00-000070 - Microsoft Defender SmartScreen Enabled ==="

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
$regName = "EnableSmartScreen"
$expectedValue = 1

try {
    if (-not (Test-Path $regPath)) {
        Write-Host "FAIL: Registry path not found: $regPath"
        exit 1
    }

    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    Write-Host "Found $regName = $currentValue"

    if ($currentValue -eq $expectedValue) {
        Write-Host "PASS: Microsoft Defender SmartScreen is enabled."
        exit 0
    } else {
        Write-Host "FAIL: Expected $regName = $expectedValue but found $currentValue"
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
