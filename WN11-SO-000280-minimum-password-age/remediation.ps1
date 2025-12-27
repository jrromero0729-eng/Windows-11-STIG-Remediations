<#
.SYNOPSIS
    DISA STIG WN11-SO-000280 requires the minimum password age to be configured.
    This remediation enforces a minimum password age of at least 1 day using local account policy settings.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-SO-000280)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-SO-000280-minimum-password-age
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

Write-Host "=== Remediation: WN11-SO-000280 - Minimum Password Age ==="

$requiredMinAgeDays = 1

try {
    Write-Host "Setting minimum password age to $requiredMinAgeDays day(s)..."
    cmd /c "net accounts /minpwage:$requiredMinAgeDays" | Out-Null

    $output = (cmd /c "net accounts") -join "`n"
    $policyLine = $output | Select-String -Pattern "Minimum password age" -SimpleMatch

    Write-Host "Current policy:"
    Write-Host $policyLine

    if ($policyLine -and ($policyLine.ToString() -match "\b$requiredMinAgeDays\b")) {
        Write-Host "SUCCESS: Minimum password age is set to $requiredMinAgeDays day(s)."
        exit 0
    } else {
        Write-Error "FAILURE: Unable to confirm minimum password age configuration."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
