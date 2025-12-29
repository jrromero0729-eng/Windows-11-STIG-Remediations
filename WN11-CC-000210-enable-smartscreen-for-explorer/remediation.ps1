<#
.SYNOPSIS
    DISA STIG WN11-CC-000210 requires Microsoft Defender SmartScreen for Explorer to be enabled.
    This remediation enables SmartScreen and configures it to "Warn and prevent bypass"
    using policy-based registry settings.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-11-21
    Last Modified   : 2025-12-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-CC-000210)

.TESTED ON
    Date(s) Tested  : 2025-11-22, 2025-12-28
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-CC-000210-enable-smartscreen-for-explorer
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

Write-Host "=== Remediation: WN11-CC-000210 - Enable Microsoft Defender SmartScreen for Explorer ==="

try {
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"

    # Required policy values
    $enableSmartScreenName = "EnableSmartScreen"
    $enableSmartScreenValue = 1

    $smartScreenLevelName = "ShellSmartScreenLevel"
    $smartScreenLevelValue = "Block"   # Warn and prevent bypass

    # Ensure registry path exists
    New-Item -Path $regPath -Force | Out-Null

    # Set EnableSmartScreen = 1
    New-ItemProperty -Path $regPath `
        -Name $enableSmartScreenName `
        -PropertyType DWord `
        -Value $enableSmartScreenValue `
        -Force | Out-Null

    # Set ShellSmartScreenLevel = Block
    New-ItemProperty -Path $regPath `
        -Name $smartScreenLevelName `
        -PropertyType String `
        -Value $smartScreenLevelValue `
        -Force | Out-Null

    # Verification
    $currentEnable = (Get-ItemProperty -Path $regPath -Name $enableSmartScreenName).$enableSmartScreenName
    $currentLevel  = (Get-ItemProperty -Path $regPath -Name $smartScreenLevelName).$smartScreenLevelName

    Write-Host "Configured $enableSmartScreenName = $currentEnable"
    Write-Host "Configured $smartScreenLevelName = $currentLevel"

    if ($currentEnable -eq 1 -and $currentLevel -eq "Block") {
        Write-Host "SUCCESS: Microsoft Defender SmartScreen for Explorer is enabled and enforced."
        Write-Host "NOTE: A reboot or 'gpupdate /force' may be required for audit validation."
        exit 0
    }
    else {
        Write-Error "FAILURE: SmartScreen settings do not match required STIG configuration."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
