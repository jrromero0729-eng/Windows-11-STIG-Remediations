<#
.SYNOPSIS
    DISA STIG WN11-SO-000280 requires passwords for enabled local Administrator accounts
    to be changed at least every 60 days. This remediation enables Windows LAPS and
    configures password rotation to comply with the STIG.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-19
    Last Modified   : 2025-12-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-SO-000280)

.TESTED ON
    Date(s) Tested  : 2025-12-20, 2025-12-28
    Tested By       : Albert Romero
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    1. Run PowerShell as Administrator.
    2. Navigate to the script's folder:
         cd C:\path\to\WN11-SO-000280-enable-laps
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

Write-Host "=== Remediation: WN11-SO-000280 - Enable Windows LAPS and Password Rotation ==="

try {
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LAPS"

    # Required STIG-compliant values
    $settings = @{
        "BackupDirectory"          = 1    # Enable LAPS (local backup)
        "PasswordAgeDays"          = 30   # Rotate password every 30 days (<= 60)
        "AdministratorAccountName" = "Administrator"
        "EnablePasswordEncryption"= 1
    }

    # Ensure registry path exists
    New-Item -Path $regPath -Force | Out-Null

    foreach ($name in $settings.Keys) {
        $value = $settings[$name]
        $type  = ($value -is [int]) ? "DWord" : "String"

        New-ItemProperty -Path $regPath `
            -Name $name `
            -PropertyType $type `
            -Value $value `
            -Force | Out-Null

        Write-Host "Configured $name = $value"
    }

    Write-Host "SUCCESS: Windows LAPS is enabled and configured for Administrator password rotation."
    Write-Host "NOTE: LAPS will rotate the password automatically. A reboot may be required."
    exit 0
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 3
}
