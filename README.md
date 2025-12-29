# Windows 11 STIG Remediations

This repository contains Windows 11 DISA STIG remediations implemented with PowerShell.  
Each STIG is organized into its own folder and includes:

- `README.md` (STIG summary + references)
- `remediation.ps1` (implements the control)
- `verification.ps1` (validates the control)

> **Note:** Settings are implemented using policy-based registry configuration or local security policy changes.  
> Validation is performed through Tenable compliance auditing and local verification scripts.

---

## STIG Index

### Completed (Initial Set)
1. **WN11-00-000155** – Disable PowerShell 2.0  
   - Folder: [`WN11-00-000155-disable-powershell-v2/`](./WN11-00-000155-disable-powershell-v2/)

2. **WN11-00-000125** – Disable Windows Copilot
   - Folder: [`WN11-00-000125-disable-windows-copilot/`](./WN11-00-000125-disable-windows-copilot/)

3. **WN11-00-000090** – Require password expiration 
   - Folder: [`WN11-00-000090-require-password-expiration/`](./WN11-00-000090-require-password-expiration/)

4. **WN11-00-000045** – Enable Windows Defender Firewall  
   - Folder: [`WN11-00-000045-enable-windows-firewall/`](./WN11-00-000045-enable-windows-firewall/)

5. **WN11-00-000070** – Enable Microsoft Defender SmartScreen  
   - Folder: [`WN11-00-000070-enable-smartscreen/`](./WN11-00-000070-enable-smartscreen/)

6. **WN11-AC-000035** – Enforce Minimum Password Length (≥14)  
   - Folder: [`WN11-AC-000035-minimum-password-length/`](./WN11-AC-000035-minimum-password-length/)

7. **WN11-AC-000005** – Account Lockout Duration (≥15 minutes)  
   - Folder: [`WN11-AC-000005-account-lockout-duration/`](./WN11-AC-000005-account-lockout-duration/)

8. **WN11-AC-000010** – Account Lockout Threshold (≤10 attempts)  
   - Folder: [`WN11-AC-000010-account-lockout-threshold/`](./WN11-AC-000010-account-lockout-threshold/)

9. **WN11-CC-000039** – Remove “Run as different user” from context menus  
   - Folder: [`WN11-CC-000039-remove-run-as-different-user/`](./WN11-CC-000039-remove-run-as-different-user/)

10. **WN11-CC-000210** – Enable Microsoft Defender SmartScreen for Explorer  
   - Folder: [`WN11-CC-000210-enable-smartscreen-for-explorer/`](./WN11-CC-000210-enable-smartscreen-for-explorer/)

11. **WN11-SO-000280** – Minimum Password Age (≥1 day)  
   - Folder: [`WN11-SO-000280-minimum-password-age/`](./WN11-SO-000280-minimum-password-age/)

12. **WN11-00-000170** – Disable SMB v1 Protocol 
   - Folder: [`WN11-00-000170-disable-smbv1-client/`](./WN11-00-000170-disable-smbv1-client/)

13. **WN11-00-000135** – Enable Host Based Firewall
   - Folder: [`WN11-00-000135-enable-host-based-firewall/`](./WN11-00-000135-enable-host-based-firewall/)

14. **WN11-CC-000315** – Disable “Always install with elevated privileges”  
   - Folder: [`WN11-CC-000315-disable-always-install-elevated/`](./WN11-CC-000315-disable-always-install-elevated/)

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

