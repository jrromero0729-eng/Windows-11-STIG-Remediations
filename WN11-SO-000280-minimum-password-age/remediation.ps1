<#
.SYNOPSIS
    DISA STIG WN11-SO-000280 requires the minimum password age to be at least one day.

.NOTES
    Author          : Albert Romero
    Date Created    : 2025-12-27
    Version         : 1.0
    Plugin IDs      : N/A (Tenable Audit STIG ID: WN11-SO-000280)

.TESTED ON
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1
#>

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Run as Administrator."
    exit 1
}

$minAge = 1
cmd /c "net accounts /minpwage:$minAge" | Out-Null
