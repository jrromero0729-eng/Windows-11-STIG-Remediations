# Windows 11 STIG Remediations

This repository contains Windows 11 DISA STIG remediations implemented with PowerShell.  
Each STIG is organized into its own folder and includes:

- `README.md` (STIG summary + references)
- `remediation.ps1` (implements the control)
- `verification.ps1` (validates the control)

> **Note:** Settings are implemented using policy-based registry configuration or local security policy changes.  
> Validation is performed through Tenable compliance auditing and local verification scripts.

---

## STIG Remediation Table

| STIG ID | Description | Language | Status | Link |
|--------|-------------|----------|--------|------|
| WN11-00-000155 | Disable PowerShell 2.0 | PowerShell | Completed | [View Folder](./WN11-00-000155-disable-powershell-v2/) |
| WN11-00-000125 | Disable Windows Copilot | PowerShell | Completed | [View Folder](./WN11-00-000125-disable-windows-copilot/) |
| WN11-00-000090 | Require password expiration | PowerShell | Completed | [View Folder](./WN11-00-000090-require-password-expiration/) |
| WN11-00-000045 | Enable Windows Defender Firewall | PowerShell | Completed | [View Folder](./WN11-00-000045-enable-windows-firewall/) |
| WN11-00-000070 | Enable Microsoft Defender SmartScreen | PowerShell | Completed | [View Folder](./WN11-00-000070-enable-smartscreen/) |
| WN11-AC-000035 | Enforce minimum password length (≥14) | PowerShell | Completed | [View Folder](./WN11-AC-000035-minimum-password-length/) |
| WN11-AC-000005 | Account lockout duration (≥15 minutes) | PowerShell | Completed | [View Folder](./WN11-AC-000005-account-lockout-duration/) |
| WN11-AC-000010 | Account lockout threshold (≤10 attempts) | PowerShell | Completed | [View Folder](./WN11-AC-000010-account-lockout-threshold/) |
| WN11-CC-000039 | Remove “Run as different user” from context menus | PowerShell | Completed | [View Folder](./WN11-CC-000039-remove-run-as-different-user/) |
| WN11-CC-000210 | Enable Microsoft Defender SmartScreen for Explorer | PowerShell | Completed | [View Folder](./WN11-CC-000210-enable-smartscreen-for-explorer/) |
| WN11-SO-000280 | Minimum password age (≥1 day) | PowerShell | Completed | [View Folder](./WN11-SO-000280-minimum-password-age/) |
| WN11-00-000170 | Disable SMB v1 protocol | PowerShell | Completed | [View Folder](./WN11-00-000170-disable-smbv1-client/) |
| WN11-00-000135 | Enable host-based firewall | PowerShell | Completed | [View Folder](./WN11-00-000135-enable-host-based-firewall/) |
| WN11-CC-000315 | Disable “Always install with elevated privileges” | PowerShell | Completed | [View Folder](./WN11-CC-000315-disable-always-install-elevated/) |


---

## How to Use

### Remediate
1. Run PowerShell as Administrator.
2. Navigate to a STIG folder.
3. Run:
   ```powershell
   .\remediation.ps1
4. Run:
   ```powershell
   .\verification.ps1

