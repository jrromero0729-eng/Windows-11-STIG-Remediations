# WN11-00-000090 – Require Password Expiration for Local Accounts

## STIG Information
- **STIG ID:** WN11-00-000090  
- **Title:** Accounts must be configured to require password expiration  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
Requiring password expiration helps reduce the risk of compromised credentials being used indefinitely. Accounts configured with non-expiring passwords increase the likelihood of successful brute force, credential stuffing, or long-term credential compromise.

On Windows 11, this requirement applies to enabled local user accounts and ensures that passwords are periodically changed.

## STIG Requirement
Accounts must be configured to require password expiration.

Compliance is achieved by ensuring that enabled local user accounts are **not configured with “Password never expires.”**

## Remediation Overview
This remediation enumerates enabled local user accounts and removes the **Password never expires** setting where it is enabled, ensuring all applicable accounts require periodic password changes.

## Files Included
- `remediation.ps1` – Configures local user accounts to require password expiration  
- `verification.ps1` – Verifies local user accounts are compliant with password expiration requirements  

## Usage
Run the remediation script with administrative privileges and then run the verification script to confirm remediation was successful:

```powershell
.\remediation.ps1
.\verification.ps1
