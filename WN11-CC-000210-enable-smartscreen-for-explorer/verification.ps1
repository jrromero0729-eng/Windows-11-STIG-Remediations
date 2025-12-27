<#
.SYNOPSIS
    DISA STIG WN11-CC-000210 requires Microsoft Defender SmartScreen for Explorer to be enabled
    with 'Warn and prevent bypass' configured.

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
    1. Run PowerShell.
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

Write-Host "=== Verification: WN11-CC-000210 - Microsoft Defender SmartScreen for Explorer ==="

try {
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"

    $expectedEnable = 1
    $expectedLevel  = "Block"

    if (-not (Test-Path $regPath)) {
        Write-Host "FAIL: Registry path not found: $regPath"
        exit 1
    }

    $currentEnable = (Get-ItemProperty -Path $regPath -Name "EnableSmartScreen").EnableSmartScreen
    $currentLevel  = (Get-ItemProperty -Path $regPath -Name "ShellSmartScreenLevel").ShellSmartScreenLevel

    Write-Host "EnableSmartScreen       = $currentEnable (Expected: 1)"
    Write-Host "ShellSmartScreenLevel   = $currentLevel (Expected: Block)"

    if ($currentEnable -eq $expectedEnable -and $currentLevel -eq $expectedLevel) {
        Write-Host "PASS: SmartScreen for Explorer is correctly configured."
        exit 0
    }
    else {
        Write-Host "FAIL: SmartScreen configuration does not meet STIG requirements."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
