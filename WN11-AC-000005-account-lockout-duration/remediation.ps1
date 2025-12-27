<#
.SYNOPSIS
    DISA STIG WN11-AC-000005 (V-253297) requires the account lockout duration
    to be set to 15 minutes or greater.
    This remediation enforces the local account lockout duration policy.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-AC-000005)

.TESTED ON
    Date(s) Tested  : 2025-12-27
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

Write-Host "=== Remediation: WN11-AC-000005 - Account Lockout Duration ==="

# DISA STIG required duration (minutes)
$requiredDuration = 15

try {
    Write-Host "Setting account lockout duration to $requiredDuration minutes..."

    cmd /c "net accounts /lockoutduration:$requiredDuration" | Out-Null

    # Post-check
    $output = (cmd /c "net accounts") -join "`n"
    $policyLine = $output | Select-String -Pattern "Lockout duration" -SimpleMatch

    Write-Host "Current policy:"
    Write-Host $policyLine

    if ($policyLine -and ($policyLine.ToString() -match "\b$requiredDuration\b")) {
        Write-Host "SUCCESS: Account lockout duration is set to $requiredDuration minutes."
        exit 0
    } else {
        Write-Error "FAILURE: Unable to confirm account lockout duration configuration."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
