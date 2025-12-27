<#
.SYNOPSIS
    DISA STIG WN11-AC-000010 requires the number of allowed bad logon attempts
    (Account lockout threshold) to be configured to three or less.
    This remediation sets the Account lockout threshold to 3 invalid logon attempts.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-AC-000010)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-AC-000010-account-lockout-threshold
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

Write-Host "=== Remediation: WN11-AC-000010 - Account Lockout Threshold (<= 3) ==="

try {
    $desiredThreshold = 3

    Write-Host "Setting account lockout threshold to $desiredThreshold invalid logon attempts..."
    $null = net accounts /lockoutthreshold:$desiredThreshold

    # Post-check
    $output = net accounts
    $line = $output | Select-String -Pattern "Lockout threshold" -ErrorAction Stop

    $currentValue = [int]([regex]::Match($line.Line, "\d+").Value)

    Write-Host "Current lockout threshold: $currentValue"
    Write-Host "Expected: 1 to 3 (0 is NOT acceptable)"

    if ($currentValue -ge 1 -and $currentValue -le 3) {
        Write-Host "SUCCESS: Account lockout threshold meets STIG requirements."
        exit 0
    } else {
        Write-Error "FAILURE: Account lockout threshold does not meet STIG requirements."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
