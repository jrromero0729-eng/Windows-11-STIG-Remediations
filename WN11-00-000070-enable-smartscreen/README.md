# WN11-00-000070 – Enable Microsoft Defender SmartScreen

## STIG Information
- **STIG ID:** WN11-00-000070  
- **Title:** Microsoft Defender SmartScreen must be enabled  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
Microsoft Defender SmartScreen helps protect systems by warning users before running unrecognized or potentially malicious applications and files downloaded from the internet. Disabling SmartScreen increases the risk of executing malicious content and exposes systems to social engineering and malware-based attacks.

## STIG Requirement
Microsoft Defender SmartScreen must be enabled.

Compliance is achieved by configuring SmartScreen through policy-based settings to ensure protection is active and cannot be bypassed by users.

## Remediation Overview
This remediation enables Microsoft Defender SmartScreen using policy-based registry configuration to ensure SmartScreen is enforced consistently across the system.

## Files Included
- `remediation.ps1` – Enables Microsoft Defender SmartScreen using policy-based configuration  
- `verification.ps1` – Verifies Microsoft Defender SmartScreen is enabled and compliant  

## Usage
Run the remediation script with administrative privileges and then run the verification script to confirm remediation was successful:

```powershell
.\remediation.ps1
.\verification.ps1

