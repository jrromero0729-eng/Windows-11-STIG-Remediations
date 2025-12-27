<#
.SYNOPSIS
    DISA STIG WN11-00-000125 requires Copilot in Windows to be disabled for Windows 11.
    This verification checks the policy registry value for "Turn off Windows Copilot" is enabled (1).

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

Write-Host "=== Verification: WN11-00-000125 - Disable Windows Copilot ==="

try {
    $regName = "TurnOffWindowsCopilot"
    $expectedValue = 1

    $hkcuPath = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"
    $hklmPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"

    $hkcuOk = $false
    $hklmOk = $false

    if (Test-Path $hkcuPath) {
        try {
            $currentHKCU = (Get-ItemProperty -Path $hkcuPath -Name $regName -ErrorAction Stop).$regName
            Write-Host "Found $hkcuPath\$regName = $currentHKCU"
            if ($currentHKCU -eq $expectedValue) { $hkcuOk = $true }
        } catch {
            Write-Host "HKCU value not found or unreadable."
        }
    } else {
        Write-Host "HKCU policy path not found: $hkcuPath"
    }

    if (Test-Path $hklmPath) {
        try {
            $currentHKLM = (Get-ItemProperty -Path $hklmPath -Name $regName -ErrorAction Stop).$regName
            Write-Host "Found $hklmPath\$regName = $currentHKLM"
            if ($currentHKLM -eq $expectedValue) { $hklmOk = $true }
        } catch {
            Write-Host "HKLM value not found or unreadable."
        }
    } else {
        Write-Host "HKLM policy path not found: $hklmPath"
    }

    if ($hkcuOk -and $hklmOk) {
        Write-Host "PASS: Windows Copilot is disabled via policy (TurnOffWindowsCopilot = 1) in both HKCU and HKLM."
        exit 0
    } else {
        Write-Host "FAIL: Windows Copilot policy is not set correctly in one or more locations."
        Write-Host "Expected: $regName = $expectedValue"
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
