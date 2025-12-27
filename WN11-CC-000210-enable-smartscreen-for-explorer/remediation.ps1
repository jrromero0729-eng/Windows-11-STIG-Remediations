<#
.SYNOPSIS
    DISA STIG WN11-CC-000210 requires Microsoft Defender SmartScreen for Explorer to be enabled.
    This remediation enforces SmartScreen for Explorer using policy-based registry settings.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Last Modified   : 2025-12-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-CC-000210)

.TESTED ON
    Date(s) Tested  : 2025-12-27
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

Write-Host "=== Remediation: WN11-CC-000210 - Enable SmartScreen for Explorer ==="

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"

try {
    New-Item -Path $regPath -Force | Out-Null

    # Enable SmartScreen
    New-ItemProperty -Path $regPath -Name "EnableSmartScreen" -PropertyType DWord -Value 1 -Force | Out-Null

    # Set SmartScreen enforcement level to "Warn and prevent bypass"
    New-ItemProperty -Path $regPath -Name "ShellSmartScreenLevel" -PropertyType String -Value "Block" -Force | Out-Null

    $enabled = (Get-ItemProperty -Path $regPath -Name "EnableSmartScreen").EnableSmartScreen
    $level   = (Get-ItemProperty -Path $regPath -Name "ShellSmartScreenLevel").ShellSmartScreenLevel

    Write-Host "EnableSmartScreen      = $enabled"
    Write-Host "ShellSmartScreenLevel  = $level"

    if ($enabled -eq 1 -and $level -eq "Block") {
        Write-Host "SUCCESS: SmartScreen for Explorer is enabled with 'Warn and prevent bypass'."
        exit 0
    } else {
        Write-Error "FAILURE: SmartScreen configuration does not match required settings."
        exit 2
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
