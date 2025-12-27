<#
.SYNOPSIS
    DISA STIG WN11-00-000155 requires the Windows PowerShell 2.0 optional feature to be disabled.
    PowerShell 2.0 is deprecated and lacks modern security protections, increasing risk of abuse.

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
    1. Save the script as: Remediate-WN11-00-000155.ps1 (or keep as remediation.ps1 in your repo)
    2. Right-click PowerShell and choose **Run as Administrator**.
    3. Navigate to the script's folder:
         cd C:\path\to\script
    4. Run the script:
         .\Remediate-WN11-00-000155.ps1

    Example syntax:
        PS C:\> .\Remediate-WN11-00-000155.ps1
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

$featureName = "MicrosoftWindowsPowerShellV2"

Write-Host "=== Remediation: WN11-00-000155 - Disable PowerShell 2.0 ==="
Write-Host "Checking current feature state: $featureName"

try {
    $feature = Get-WindowsOptionalFeature -Online -FeatureName $featureName -ErrorAction Stop
    Write-Host "Current State: $($feature.State)"

    if ($feature.State -eq "Disabled") {
        Write-Host "No action required. PowerShell 2.0 is already disabled."
        exit 0
    }

    Write-Host "Disabling PowerShell 2.0 feature..."
    Disable-WindowsOptionalFeature -Online -FeatureName $featureName -NoRestart -ErrorAction Stop | Out-Null

    # Re-check state
    $featureAfter = Get-WindowsOptionalFeature -Online -FeatureName $featureName -ErrorAction Stop
    Write-Host "New State: $($featureAfter.State)"

    if ($featureAfter.State -eq "Disabled") {
        Write-Host "SUCCESS: PowerShell 2.0 has been disabled."
        Write-Host "NOTE: If Tenable still reports failure, reboot the system and re-scan."
        exit 0
    } else {
        Write-Error "FAILURE: Feature state did not change to Disabled. Current: $($featureAfter.State)"
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}

