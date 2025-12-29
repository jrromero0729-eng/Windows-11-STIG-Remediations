# WN11-AC-000005 – Account Lockout Duration

## STIG Information
- **STIG ID:** WN11-AC-000005  
- **Title:** The account lockout duration must be configured to 15 minutes or greater  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
Configuring an account lockout duration helps protect systems from brute-force
authentication attacks by enforcing a minimum amount of time an account remains
locked after exceeding the allowed number of failed logon attempts. This reduces the
effectiveness of automated password-guessing attacks.

## STIG Requirement
The account lockout duration must be configured to **15 minutes or greater**.

Compliance is achieved by configuring the account lockout policy to enforce a minimum
lockout duration of 15 minutes.

## Remediation Overview
This remediation configures the local account lockout duration to meet DISA STIG
requirements, ensuring accounts remain locked for at least 15 minutes following
multiple failed authentication attempts.

## Files Included
- `remediation.ps1` – Configures the account lockout duration to 15 minutes or greater  
- `verification.ps1` – Verifies the account lockout duration is compliant  

## Usage
Run the remediation script with administrative privileges and then run the verification script to confirm remediation was successful:

```powershell
.\remediation.ps1
.\verification.ps1
