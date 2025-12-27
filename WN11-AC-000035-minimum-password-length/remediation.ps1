<#
.SYNOPSIS
    DISA STIG WN11-AC-000035 (V-253303) requires a minimum password length of 14 characters.
    This remediation enforces the local password policy using built-in Windows account policy configuration.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-AC-000035)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-AC-000035-minimum-password-length
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

Write-Host "=== Remediation: WN11-AC-000035 - Minimum Password Length ==="

# DISA STIG required minimum length
$requiredMinLength = 14

try {
    Write-Host "Setting minimum password length to $requiredMinLength characters..."

    cmd /c "net accounts /minpwlen:$requiredMinLength" | Out-Null

    # Post-check
    $output = (cmd /c "net accounts") -join "`n"
    $policyLine = $output | Select-String -Pattern "Minimum password length" -SimpleMatch

    Write-Host "Current policy:"
    Write-Host $policyLine

    if ($policyLine -and ($policyLine.ToString() -match "\b$requiredMinLength\b")) {
        Write-Host "SUCCESS: Minimum password length is set to $requiredMinLength."
        exit 0
    } else {
        Write-Error "FAILURE: Unable to confirm minimum password length configuration."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
