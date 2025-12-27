<#
.SYNOPSIS
    Verification script for DISA STIG WN11-00-000125.
    Confirms Windows Copilot is disabled via policy registry configuration (no changes are made).

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000125)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000125-disable-windows-copilot
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-00-000125 - Windows Copilot Disabled ==="

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"
$regName = "TurnOffWindowsCopilot"
$expectedValue = 1

try {
    if (-not (Test-Path $regPath)) {
        Write-Host "FAIL: Policy key not found: $regPath"
        exit 1
    }

    $value = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    Write-Host "Found $regName = $value"

    if ($value -eq $expectedValue) {
        Write-Host "PASS: Windows Copilot is disabled by policy."
        exit 0
    } else {
        Write-Host "FAIL: Expected $regName = $expectedValue but found $value"
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
