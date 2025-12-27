<#
STIG ID: WN11-00-000155
Title : Disable PowerShell 2.0
#>

Disable-WindowsOptionalFeature `
  -Online `
  -FeatureName MicrosoftWindowsPowerShellV2 `
  -NoRestart
