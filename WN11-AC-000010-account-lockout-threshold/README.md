# WN11-AC-000010 – Account Lockout Threshold

This folder contains remediation and verification scripts for DISA STIG WN11-AC-000010 on Windows 11.

## Summary
Implements DISA STIG WN11-AC-000010 (V-253298) by enforcing an account lockout threshold
of 10 or fewer invalid logon attempts to mitigate brute-force attacks.

## STIG Details
- STIG ID: WN11-AC-000010
- Vulnerability ID: V-253298
- Required Threshold: ≤ 10 invalid logon attempts
- Policy Area: Account Policies → Account Lockout Policy

## Included Files
- remediation.ps1
- verification.ps1
