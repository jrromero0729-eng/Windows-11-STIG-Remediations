<#
.SYNOPSIS
    Windows 11 STIG requires a minimum password length to be enforced.
    This remediation sets the local minimum password length using built-in account policy configuration.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit - Minimum Password Length)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-SO-min-password-length
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

Write-Host "=== Remediation: Windows 11 STIG - Minimum Password Length ==="

# Set the minimum password length required by your STIG/audit.
# Common STIG baseline is 14 characters; adjust here if your audit requires a different value.
$minLength = 14

try {
    Write-Host "Setting minimum password length to $minLength..."
    cmd /c "net accounts /minpwlen:$minLength" | Out-Null

    # Verify after setting
    $current = (cmd /c "net accounts") -join "`n"
    $match = $current | Select-String -Pattern "Minimum password length" -SimpleMatch

    Write-Host "Current policy line:"
    Write-Host $match

    if ($match -and ($match.ToString() -match "\b$minLength\b")) {
        Write-Host "SUCCESS: Minimum password length is set to $minLength."
        exit 0
    } else {
        Write-Error "FAILURE: Could not confirm the expected minimum password length in policy output."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
