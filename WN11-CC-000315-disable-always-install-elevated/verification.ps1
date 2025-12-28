<#
.SYNOPSIS
    Verifies DISA STIG WN11-CC-000315 compliance by confirming the Windows Installer
    policy 'Always install with elevated privileges' is disabled.

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
    1. Run PowerShell.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-CC-000315-disable-alwaysinstall-elevated
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-CC-000315 - AlwaysInstallElevated Disabled ==="

try {
    $expectedValue = 0
    $regName = "AlwaysInstallElevated"

    $regPathHKLM = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
    $regPathHKCU = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer"

    $hklmValue = $null
    $hkcuValue = $null

    if (Test-Path $regPathHKLM) {
        try { $hklmValue = (Get-ItemProperty -Path $regPathHKLM -Name $regName -ErrorAction Stop).$regName } catch { $hklmValue = $null }
    }

    if (Test-Path $regPathHKCU) {
        try { $hkcuValue = (Get-ItemProperty -Path $regPathHKCU -Name $regName -ErrorAction Stop).$regName } catch { $hkcuValue = $null }
    }

    Write-Host "HKLM $regPathHKLM\$regName = $hklmValue"
    Write-Host "HKCU $regPathHKCU\$regName = $hkcuValue"
    Write-Host "Expected value = $expectedValue (Disabled)"

    if ($hklmValue -eq $expectedValue -and $hkcuValue -eq $expectedValue) {
        Write-Host "PASS: WN11-CC-000315 is compliant. AlwaysInstallElevated is disabled."
        exit 0
    }
    else {
        Write-Host "FAIL: WN11-CC-000315 is NOT compliant. AlwaysInstallElevated must be set to 0."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
