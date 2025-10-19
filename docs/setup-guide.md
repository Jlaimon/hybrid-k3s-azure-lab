# Setup Guide

This guide summarizes the end-to-end process described in the thesis:

1. **Flash Raspberry Pi CM4** modules with Raspberry Pi OS (64-bit).
2. Enable SSH and assign static IPs (e.g., 192.168.137.11..16).
3. On the master (192.168.137.11), install Ansible and clone this repo.
4. Fill `ansible/vars/cluster_vars.yml` with your Azure credentials and settings.
5. Verify connectivity: `ansible -i ansible/hosts.ini all -m ping`.
6. Deploy base tools and K3s: `ansible-playbook ... main.yml && k3s.yml`.
7. Connect to **Azure Arc**: `ansible-playbook ... azure-arc.yml`.
8. (Optional) Provision an **Azure Jump Host**: `ansible-playbook ... install-jump-host.yml`.
9. Onboard students with `generate-ssh-key.yml` and `add-student-user.yml`.
