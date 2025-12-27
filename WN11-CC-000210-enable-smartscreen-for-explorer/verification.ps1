<#
.SYNOPSIS
    Verification script for DISA STIG WN11-CC-000210.
    Confirms Microsoft Defender SmartScreen for Explorer is enabled via policy configuration.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-CC-000210)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-CC-000210-enable-smartscreen-for-explorer
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-CC-000210 - SmartScreen for Explorer ==="

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"

try {
    if (-not (Test-Path $regPath)) {
        Write-Host "FAIL: Registry path not found."
        exit 1
    }

    $enabled = (Get-ItemProperty -Path $regPath -Name "EnableSmartScreen").EnableSmartScreen
    $level   = (Get-ItemProperty -Path $regPath -Name "ShellSmartScreenLevel").ShellSmartScreenLevel

    Write-Host "EnableSmartScreen      = $enabled"
    Write-Host "ShellSmartScreenLevel  = $level"

    if ($enabled -eq 1 -and $level -eq "Block") {
        Write-Host "PASS: SmartScreen for Explorer is enabled with 'Warn and prevent bypass'."
        exit 0
    } else {
        Write-Host "FAIL: SmartScreen for Explorer is not correctly configured."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
