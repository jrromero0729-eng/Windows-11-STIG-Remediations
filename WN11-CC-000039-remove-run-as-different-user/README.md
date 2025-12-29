# WN11-CC-000039 – Remove "Run as different user" from Context Menus

## STIG Information
- **STIG ID:** WN11-CC-000039  
- **Title:** The "Run as different user" option must be removed from context menus  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
The "Run as different user" option allows users to execute applications under alternate
credentials. In controlled or high-security environments, this capability increases the
risk of privilege misuse and credential exposure. Removing this option helps enforce
least privilege and reduces the likelihood of unauthorized privilege escalation.

## STIG Requirement
The "Run as different user" option must be removed from Windows context menus.

Compliance is achieved by configuring the appropriate policy setting under the
**MS Security Guide** administrative templates to remove this option from context menus.

## Remediation Overview
This remediation removes the "Run as different user" option from Windows context menus
using policy-based registry configuration, ensuring the option is unavailable to users.

## Files Included
- `remediation.ps1` – Removes the "Run as different user" option from context menus  
- `verification.ps1` – Verifies the context menu option has been removed and is compliant  

## Usage
Run the remediation script with administrative privileges and then run the verification script to confirm remediation was successful:

```powershell
.\remediation.ps1
.\verification.ps1
