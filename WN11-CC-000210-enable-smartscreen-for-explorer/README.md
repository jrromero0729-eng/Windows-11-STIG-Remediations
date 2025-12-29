# WN11-CC-000210 – Enable Microsoft Defender SmartScreen for Explorer

## STIG Information
- **STIG ID:** WN11-CC-000210  
- **Title:** Microsoft Defender SmartScreen for Explorer must be enabled  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
Microsoft Defender SmartScreen for Explorer helps protect users by warning or blocking
the execution of unrecognized or potentially malicious applications and files accessed
through Windows Explorer. Disabling SmartScreen for Explorer increases the risk of users
running malicious content and undermines built-in system protections.

## STIG Requirement
Microsoft Defender SmartScreen for Explorer must be enabled.

Compliance is achieved by configuring SmartScreen through policy-based settings to ensure
it is enforced for Windows Explorer and cannot be bypassed by users.

## Remediation Overview
This remediation enables Microsoft Defender SmartScreen for Windows Explorer using
policy-based registry configuration, ensuring SmartScreen protections are consistently
applied at the system level.

## Files Included
- `remediation.ps1` – Enables Microsoft Defender SmartScreen for Explorer  
- `verification.ps1` – Verifies SmartScreen for Explorer is enabled and compliant  

## Usage
Run the remediation script with administrative privileges and then run the verification script to confirm remediation was successful:

```powershell
.\remediation.ps1
.\verification.ps1
