# WN11-CC-000315 – Disable "Always install with elevated privileges"

## STIG Information
- **STIG ID:** WN11-CC-000315  
- **Title:** The Windows Installer feature "Always install with elevated privileges" must be disabled  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
The Windows Installer policy **"Always install with elevated privileges"** allows MSI
packages to install with administrative privileges, even when initiated by standard
users. If enabled, this setting can be exploited by malicious users to gain elevated
privileges and execute unauthorized software.

Disabling this feature helps enforce the principle of least privilege and reduces the
risk of privilege escalation.

## STIG Requirement
The Windows Installer feature **"Always install with elevated privileges"** must be
disabled.

Compliance is achieved by configuring the Windows Installer policy to ensure the
**AlwaysInstallElevated** setting is disabled.

## Remediation Overview
This remediation disables the Windows Installer **AlwaysInstallElevated** policy using
policy-based registry configuration, ensuring MSI packages cannot be installed with
elevated privileges unless explicitly authorized.

## Files Included
- `remediation.ps1` – Disables the "Always install with elevated privileges" policy  
- `verification.ps1` – Verifies the policy is disabled and compliant  

## Usage
Run the remediation script with administrative privileges and then run the verification script to confirm remediation was successful:

```powershell
.\remediation.ps1
.\verification.ps1
