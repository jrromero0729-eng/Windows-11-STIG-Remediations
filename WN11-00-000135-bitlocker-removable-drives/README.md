# WN11-00-000135 – Enable Host-Based Firewall

## STIG Information
- **STIG ID:** WN11-00-000135
- **Title:** A host-based firewall must be installed and enabled on the system
- **Severity:** CAT II
- **Platform:** Windows 11
- **Benchmark:** DISA Microsoft Windows 11 STIG

## Description
A host-based firewall provides a critical line of defense by monitoring and controlling
incoming and outgoing network traffic based on predefined security rules. Disabling or
removing a firewall increases the system’s exposure to network-based attacks.

## STIG Requirement
A host-based firewall must be installed and enabled on the system.

On Windows 11, this requirement is satisfied by ensuring **Windows Defender Firewall**
is enabled for all network profiles.

## Remediation Overview
This remediation ensures that Windows Defender Firewall is enabled on the system.
The script verifies firewall status and enables it if it is found to be disabled.

## Files Included
- `remediation.ps1` – Enables Windows Defender Firewall if disabled
- `verification.ps1` – Verifies the firewall is enabled and compliant with the STIG

## Usage
Run the remediation script with administrative privileges:

```powershell
.\remediation.ps1
