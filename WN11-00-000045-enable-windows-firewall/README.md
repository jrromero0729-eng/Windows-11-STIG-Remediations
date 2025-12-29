# WN11-00-000045 – Enable Windows Defender Firewall

## STIG Information
- **STIG ID:** WN11-00-000045  
- **Title:** A host-based firewall must be installed and enabled on the system  
- **Severity:** CAT II  
- **Platform:** Windows 11  
- **Benchmark:** DISA Microsoft Windows 11 STIG  

## Description
A host-based firewall provides a critical line of defense by monitoring and controlling inbound and outbound network traffic based on predefined security rules. Disabling or failing to enable a firewall significantly increases a system’s exposure to network-based attacks.

Windows Defender Firewall is the built-in host-based firewall for Windows 11 and must be enabled to meet this security requirement.

## STIG Requirement
A host-based firewall must be installed and enabled on the system.

Compliance on Windows 11 is achieved by ensuring **Windows Defender Firewall** is enabled for all network profiles:
- Domain
- Private
- Public

## Remediation Overview
This remediation ensures Windows Defender Firewall is enabled on the system by enforcing firewall state across all network profiles using policy-based configuration.

## Files Included
- `remediation.ps1` – Enables Windows Defender Firewall for all network profiles  
- `verification.ps1` – Verifies Windows Defender Firewall is enabled and compliant  

## Usage
Run the remediation script with administrative privileges:

```powershell
.\remediation.ps1

After the remediation, run the verification script.
.\verification.ps1

