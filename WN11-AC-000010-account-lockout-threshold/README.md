# WN11-AC-000010 – Account Lockout Threshold

## STIG Information
- **STIG ID:** WN11-AC-000010  
- **Title:** The account lockout threshold must be configured to 10 or fewer invalid logon attempts  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
Configuring an appropriate account lockout threshold helps mitigate brute-force and
credential-guessing attacks by limiting the number of consecutive failed logon attempts
before an account is locked. Setting the threshold too high increases the likelihood of
successful password attacks.

## STIG Requirement
The account lockout threshold must be configured to **10 or fewer invalid logon attempts**.

Compliance is achieved by configuring the account lockout policy to enforce a maximum
of 10 failed logon attempts before an account is locked.

## Remediation Overview
This remediation configures the local account lockout threshold to meet DISA STIG
requirements, ensuring accounts are locked after no more than 10 consecutive failed
authentication attempts.

## Files Included
- `remediation.ps1` – Configures the account lockout threshold to 10 or fewer attempts  
- `verification.ps1` – Verifies the account lockout threshold is compliant  

## Usage
Run the remediation script with administrative privileges and then run the verification script to confirm remediation was successful:

```powershell
.\remediation.ps1
.\verification.ps1
