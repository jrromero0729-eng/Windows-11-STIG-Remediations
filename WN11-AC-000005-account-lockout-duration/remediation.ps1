<#
.SYNOPSIS
    DISA STIG WN11-AC-000005 requires the Windows 11 account lockout duration to be configured to 15 minutes or greater.
    This remediation configures the local Account Lockout Policy "Account lockout duration" to 15 minutes.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-10-24
    Last Modified   : 2025-12-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-AC-000005)

.TESTED ON
    Date(s) Tested  : 2025-10-25, 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-AC-000005-account-lockout-duration
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

Write-Host "=== Remediation: WN11-AC-000005 - Account Lockout Duration (>= 15 minutes) ==="

try {
    $desiredMinutes = 15

    # Configure account lockout duration
    Write-Host "Setting account lockout duration to $desiredMinutes minutes..."
    $null = net accounts /lockoutduration:$desiredMinutes

    # Post-check using net accounts output
    $output = net accounts
    $line = $output | Select-String -Pattern "Lockout duration" -ErrorAction Stop

    # Extract the first number from the line (minutes)
    $minutes = [int]([regex]::Match($line.Line, "\d+").Value)

    Write-Host "Current lockout duration (minutes): $minutes"

    if ($minutes -ge 15 -or $minutes -eq 0) {
        Write-Host "SUCCESS: Account lockout duration meets STIG requirements (>=15 or =0)."
        exit 0
    } else {
        Write-Error "FAILURE: Account lockout duration does not meet STIG requirements."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
