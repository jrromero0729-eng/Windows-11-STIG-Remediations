# WN11-SO-000280 – Minimum Password Age

## STIG Information
- **STIG ID:** WN11-SO-000280  
- **Title:** The minimum password age must be configured to at least one day  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
Configuring a minimum password age prevents users from repeatedly changing their
passwords in rapid succession to circumvent password history and reuse controls.
Without a minimum age, users could immediately revert to previously used passwords,
undermining password policy effectiveness.

## STIG Requirement
The minimum password age must be configured to **at least one day**.

Compliance is achieved by configuring the local password policy to enforce a minimum
password age of one day or greater for all local user accounts.

## Remediation Overview
This remediation configures the local password policy to enforce a minimum password age
of at least one day, ensuring users cannot immediately reuse previous passwords and that
password history controls remain effective.

## Files Included
- `remediation.ps1` – Configures the minimum password age to at least one day  
- `verification.ps1` – Verifies the minimum password age is compliant  

## Usage
Run the remediation script with administrative privileges and then run the verification script to confirm remediation was successful:

```powershell
.\remediation.ps1
.\verification.ps1
