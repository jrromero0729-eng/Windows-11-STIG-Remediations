# WN11-00-000155 – Disable PowerShell 2.0

## STIG Information
- **STIG ID:** WN11-00-000155  
- **Title:** Windows PowerShell 2.0 must be disabled  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
Windows PowerShell 2.0 is a deprecated version of PowerShell that lacks modern security
features such as enhanced logging and constrained language mode. Leaving PowerShell
2.0 enabled increases the risk of exploitation by attackers seeking to evade detection
and security controls.

## STIG Requirement
Windows PowerShell 2.0 must be disabled.

Compliance is achieved by disabling the Windows optional features associated with
PowerShell 2.0 to ensure the legacy engine cannot be used.

## Remediation Overview
This remediation disables both Windows PowerShell 2.0 optional features using supported
Windows commands, ensuring the legacy PowerShell engine is fully disabled on the system.

A system reboot may be required for the change to take full effect and be validated by
compliance scanning tools.

## Files Included
- `remediation.ps1` – Disables Windows PowerShell 2.0 optional features  
- `verification.ps1` – Verifies Windows PowerShell 2.0 is disabled and compliant  

## Usage
Run the remediation script with administrative privileges and then run the verification script to confirm remediation was successful:

```powershell
.\remediation.ps1
.\verification.ps1
