<#
.SYNOPSIS
    DISA STIG WN11-00-000155 requires the Windows PowerShell 2.0 feature to be disabled on the system.
    This verification checks that both optional features associated with PowerShell 2.0 are disabled:
    - MicrosoftWindowsPowerShellV2Root
    - MicrosoftWindowsPowerShellV2

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-10-10
    Last Modified   : 2025-12-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000155)

.TESTED ON
    Date(s) Tested  : 2025-10-11, 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell (Administrator recommended).
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000155-disable-powershell-v2
    3. Run the script:
         .\verification.ps1

    Example syntax:
        PS C:\> .\verification.ps1
#>

# -------------------------
# Main Script
# -------------------------

Write-Host "=== Verification: WN11-00-000155 - Disable Windows PowerShell 2.0 ==="

try {
    $features = @(
        "MicrosoftWindowsPowerShellV2Root",
        "MicrosoftWindowsPowerShellV2"
    )

    $results = foreach ($f in $features) {
        Get-WindowsOptionalFeature -Online -FeatureName $f -ErrorAction Stop |
            Select-Object FeatureName, State
    }

    Write-Host "Current feature states:"
    $results | Format-Table -AutoSize

    $nonCompliant = $results | Where-Object { $_.State -ne "Disabled" }

    if (-not $nonCompliant) {
        Write-Host "PASS: PowerShell 2.0 optional features are disabled."
        exit 0
    } else {
        Write-Host "FAIL: One or more PowerShell 2.0 optional features are not disabled:"
        $nonCompliant | Format-Table -AutoSize
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
