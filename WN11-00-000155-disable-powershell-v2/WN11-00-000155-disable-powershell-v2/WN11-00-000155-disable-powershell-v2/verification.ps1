<#
STIG ID: WN11-00-000155
Purpose: Verify PowerShell 2.0 is disabled
#>

$feature = Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2

if ($feature.State -eq "Disabled") {
    Write-Host "PASS: PowerShell 2.0 is disabled."
} else {
    Write-Host "FAIL: PowerShell 2.0 is enabled."
}
