<#
STIG ID: WN11-00-000155
Title : Windows PowerShell 2.0 feature must be disabled
#>

Write-Host "Applying STIG WN11-00-000155 remediation..."

Disable-WindowsOptionalFeature `
  -Online `
  -FeatureName MicrosoftWindowsPowerShellV2 `
  -NoRestart

Write-Host "Remediation complete."
