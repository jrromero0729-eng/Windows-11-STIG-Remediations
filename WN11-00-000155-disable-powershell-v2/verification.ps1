<#
.SYNOPSIS
    Verification script for DISA STIG WN11-00-000155.
    Confirms the Windows PowerShell 2.0 optional feature is disabled (no changes are made).

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
    1. Save the script as: Verify-WN11-00-000155.ps1 (or keep as verification.ps1 in your repo)
    2. Right-click PowerShell and choose **Run as Administrator** (recommended for consistent results).
    3. Navigate to the script's folder:
         cd C:\path\to\script
    4. Run the script:
         .\Verify-WN11-00-000155.ps1

    Example syntax:
        PS C:\> .\Verify-WN11-00-000155.ps1
#>

# -------------------------
# Main Script
# -------------------------

$featureName = "MicrosoftWindowsPowerShellV2"

Write-Host "=== Verification: WN11-00-000155 - PowerShell 2.0 Disabled ==="
Write-Host "Checking feature state: $featureName"

try {
    $feature = Get-WindowsOptionalFeature -Online -FeatureName $featureName -ErrorAction Stop
    Write-Host "State: $($feature.State)"

    if ($feature.State -eq "Disabled") {
        Write-Host "PASS: PowerShell 2.0 feature is disabled."
        exit 0
    } else {
        Write-Host "FAIL: PowerShell 2.0 feature is NOT disabled."
        Write-Host "Recommended fix: Run the remediation script to disable the feature."
        exit 1
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 2
}
