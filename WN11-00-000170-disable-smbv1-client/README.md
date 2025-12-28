# WN11-00-000170 – Disable SMBv1 Client

## STIG Information
- **STIG ID:** WN11-00-000170
- **Title:** The Server Message Block (SMB) v1 protocol must be disabled on the SMB client
- **Severity:** CAT II
- **Platform:** Windows 11
- **Benchmark:** DISA Microsoft Windows 11 STIG

## Description
SMBv1 is a legacy file-sharing protocol that is vulnerable to multiple attack techniques
and is not FIPS-compliant. Disabling SMBv1 on the client mitigates downgrade attacks
and reduces exposure to insecure network services.

## STIG Requirement
The SMBv1 protocol must be disabled on the SMB client.

Compliance is achieved by disabling the SMBv1 client driver through registry configuration.

## Remediation Overview
This remediation disables the SMBv1 client driver by configuring the required registry
value, ensuring the driver is set to a disabled state.

A system reboot is required for the change to fully take effect.

## Files Included
- `remediation.ps1` – Disables the SMBv1 client driver
- `verification.ps1` – Verifies the SMBv1 client driver is disabled

## Usage
Run the remediation script with administrative privileges:

```powershell
.\remediation.ps1
 verification.ps1
