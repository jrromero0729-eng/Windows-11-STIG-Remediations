<#
.SYNOPSIS
    Verifies DISA STIG WN11-00-000170 compliance by confirming the SMBv1
    client driver is disabled via registry configuration.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-10-17
    Last Modified   : 2025-12-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000170)

.TESTED ON
    Date(s) Tested  : 2025-10-18, 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000170-disable-smbv1-client
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-00-000170 - SMBv1 Client Disabled ==="

try {
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10"
    $regName = "Start"
    $expectedValue = 4

    if (-not (Test-Path $regPath)) {
        Write-Host "FAIL: SMBv1 client driver registry path not found."
        exit 1
    }

    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
    Write-Host "Found $regPath\$regName = $currentValue"
    Write-Host "Expected value = $expectedValue (Disabled)"

    if ($currentValue -eq $expectedValue) {
        Write-Host "PASS: SMBv1 client protocol is disabled."
        exit 0
    }
    else {
        Write-Host "FAIL: SMBv1 client protocol is not disabled."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
