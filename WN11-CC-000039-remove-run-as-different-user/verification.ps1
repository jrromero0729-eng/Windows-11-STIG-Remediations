<#
.SYNOPSIS
    DISA STIG WN11-CC-000039 requires 'Run as different user' to be removed from context menus.
    This verification checks the policy registry value is set to remove/hide the option.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-11-14
    Last Modified   : 2025-12-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-CC-000039)

.TESTED ON
    Date(s) Tested  : 2025-11-15, 2025-12-28
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-CC-000039-remove-run-as-different-user
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-CC-000039 - Remove 'Run as different user' from context menus ==="

try {
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
    $regName = "ShowRunAsDifferentUserInStart"
    $expectedValue = 0

    if (-not (Test-Path $regPath)) {
        Write-Host "FAIL: Policy registry path not found: $regPath"
        exit 1
    }

    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    Write-Host "Found $regPath\$regName = $currentValue"
    Write-Host "Expected $regName = $expectedValue (0 = remove/hide 'Run as different user')"

    if ($currentValue -eq $expectedValue) {
        Write-Host "PASS: Policy is set correctly to remove/hide 'Run as different user'."
        exit 0
    } else {
        Write-Host "FAIL: Policy value is not set correctly."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
