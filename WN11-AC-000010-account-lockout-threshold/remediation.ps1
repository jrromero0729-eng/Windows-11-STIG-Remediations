<#
.SYNOPSIS
    DISA STIG WN11-AC-000010 (V-253298) requires the account lockout threshold
    to be set to 10 or fewer invalid logon attempts.
    This remediation enforces the local account lockout threshold policy.

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

Write-Host "=== Remediation: WN11-AC-000010 - Account Lockout Threshold ==="

# DISA STIG compliant threshold (10 or fewer)
$requiredThreshold = 10

try {
    Write-Host "Setting account lockout threshold to $requiredThreshold invalid attempts..."

    cmd /c "net accounts /lockoutthreshold:$requiredThreshold" | Out-Null

    # Post-check
    $output = (cmd /c "net accounts") -join "`n"
    $policyLine = $output | Select-String -Pattern "Lockout threshold" -SimpleMatch

    Write-Host "Current policy:"
    Write-Host $policyLine

    if ($policyLine -and ($policyLine.ToString() -match "\b$requiredThreshold\b")) {
        Write-Host "SUCCESS: Account lockout threshold is set to $requiredThreshold attempts."
        exit 0
    } else {
        Write-Error "FAILURE: Unable to confirm account lockout threshold configuration."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
