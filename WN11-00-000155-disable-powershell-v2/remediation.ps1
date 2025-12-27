<#
.SYNOPSIS
    DISA STIG WN11-00-000155 requires the Windows PowerShell 2.0 feature to be disabled on the system.
    This remediation disables both optional features associated with PowerShell 2.0:
    - MicrosoftWindowsPowerShellV2Root
    - MicrosoftWindowsPowerShellV2

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-00-000155)

.TESTED ON
    Date(s) Tested  : 2025-12-27
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-00-000155-disable-powershell-v2
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

Write-Host "=== Remediation: WN11-00-000155 - Disable Windows PowerShell 2.0 ==="

try {
    $features = @(
        "MicrosoftWindowsPowerShellV2Root",
        "MicrosoftWindowsPowerShellV2"
    )

    foreach ($f in $features) {
        Write-Host "Disabling optional feature: $f"
        Disable-WindowsOptionalFeature -Online -FeatureName $f -NoRestart -ErrorAction Stop | Out-Null
    }

    # Verify state after remediation
    $results = foreach ($f in $features) {
        Get-WindowsOptionalFeature -Online -FeatureName $f -ErrorAction Stop |
            Select-Object FeatureName, State
    }

    Write-Host "Post-remediation feature states:"
    $results | Format-Table -AutoSize

    $nonCompliant = $results | Where-Object { $_.State -ne "Disabled" }

    if (-not $nonCompliant) {
        Write-Host "SUCCESS: PowerShell 2.0 optional features are disabled."
        Write-Host "NOTE: A reboot may be required for Tenable to validate the change."
        exit 0
    } else {
        Write-Error "FAILURE: One or more PowerShell 2.0 features are not disabled:"
        $nonCompliant | Format-Table -AutoSize
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
