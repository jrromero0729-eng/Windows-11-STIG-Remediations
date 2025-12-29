# WN11-AC-000035 – Enforce Minimum Password Length

## STIG Information
- **STIG ID:** WN11-AC-000035  
- **Title:** The minimum password length must be configured to at least 14 characters  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
Enforcing a strong minimum password length helps protect systems against brute-force
and credential-guessing attacks by increasing the complexity and entropy of user
passwords. Short passwords are more susceptible to compromise through automated
attack techniques.

## STIG Requirement
The minimum password length must be configured to **at least 14 characters**.

Compliance is achieved by configuring the local password policy to enforce a minimum
password length of 14 characters or greater.

## Remediation Overview
This remediation configures the local password policy to enforce a minimum password
length of 14 characters, ensuring all local user accounts meet DISA STIG requirements.

## Files Included
- `remediation.ps1` – Configures the minimum password length to at least 14 characters  
- `verification.ps1` – Verifies the minimum password length is compliant  

## Usage
Run the remediation script with administrative privileges and then run the verification script to confirm remediation was successful:

```powershell
.\remediation.ps1
.\verification.ps1
