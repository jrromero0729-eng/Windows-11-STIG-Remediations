# WN11-00-000125 – Disable Windows Copilot

## STIG Information
- **STIG ID:** WN11-00-000125  
- **Title:** Windows Copilot must be disabled  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
Windows Copilot introduces cloud-connected functionality that may expose sensitive
information and expand the system attack surface. In secure or regulated environments,
Copilot must be disabled to prevent unauthorized data exposure and ensure compliance
with security baselines.

## STIG Requirement
Windows Copilot must be disabled.

Compliance is achieved by configuring the **“Turn off Windows Copilot”** policy to
prevent Copilot from being available to users.

## Remediation Overview
This remediation disables Windows Copilot using policy-based registry configuration,
ensuring the feature is turned off at the system level and cannot be re-enabled by users.

## Files Included
- `remediation.ps1` – Disables Windows Copilot using policy-based registry settings  
- `verification.ps1` – Verifies Windows Copilot is disabled and compliant  

## Usage
Run the remediation script with administrative privileges:

```powershell
.\remediation.ps1
