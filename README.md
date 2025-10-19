#  Hybrid Cloud Education Lab using DeskPi Super6C and Azure Arc


###  Bachelor Project – Faculty of Electrical Engineering and Informatics  
**Technical University of Košice (FEI TUKE)**  
Author: *Pavlo Tverdyi, 2025*  

---

##  Project Overview

This repository contains a reproducible setup of a **hybrid cloud education lab**:
- Local **K3s** cluster on **DeskPi Super6C** (6× Raspberry Pi CM4),
- Automated by **Ansible**,
- Connected to **Microsoft Azure Arc**,
- With an **Azure Jump Host VM** for secure student access.

> This structure and scripts are based on the author's bachelor thesis.

---

##  Architecture (ASCII)

```
                 ┌──────────────────────────────┐
                 │      Microsoft Azure Arc      │
                 │  Cloud Management & Monitoring│
                 └──────────────┬───────────────┘
                                │
                                ▼
                 ┌──────────────────────────────┐
                 │         Jump Host VM         │
                 │  (Azure Virtual Machine, SSH)│
                 └──────────────┬───────────────┘
                                │ Secure SSH Tunnel
                                ▼
      ┌────────────────────────────────────────────────────────┐
      │              DeskPi Super6C Cluster Board              │
      │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
      │  │  CM4 Node 1 │  │  CM4 Node 2 │  │  CM4 Node 3 │ ... │
      │  │ (Master)    │  │ (Worker)    │  │ (Worker)    │     │
      │  └─────────────┘  └─────────────┘  └─────────────┘     │
      │         ↓ K3s Kubernetes Cluster + Containerd/Docker   │
      └────────────────────────────────────────────────────────┘
```

---

##  Repository Layout

```
ansible/
  hosts.ini
  main.yml
  k3s.yml
  docker.yml
  azure-arc.yml
  install-jump-host.yml
  generate-ssh-key.yml
  add-student-user.yml
  vars/cluster_vars.yml
scripts/
  flash_cm4.sh
  test_connection.sh
  cleanup.sh
docs/
  setup-guide.md
LICENSE
```

---

##  Quick Start

```bash
# 0) Install Ansible on the master Pi (192.168.137.11)
sudo apt update && sudo apt install -y python3-pip python3-venv git
python3 -m pip install --user ansible

# 1) Test connectivity
ansible -i ansible/hosts.ini all -m ping

# 2) Base tools on all nodes
ansible-playbook -i ansible/hosts.ini ansible/main.yml

# 3) Install K3s (server+agents)
ansible-playbook -i ansible/hosts.ini ansible/k3s.yml

# 4) (Optional) Install Docker runtime for local testing
ansible-playbook -i ansible/hosts.ini ansible/docker.yml

# 5) Connect cluster to Azure Arc
ansible-playbook -i ansible/hosts.ini ansible/azure-arc.yml
```

### Student onboarding (Jump Host path)
```bash
# Generate keys locally and register a student user on Jump Host
ansible-playbook -i ansible/hosts.ini ansible/generate-ssh-key.yml -e student_name=student1
ansible-playbook -i ansible/hosts.ini ansible/add-student-user.yml -e student_name=student1
```

---

##  Security
- Each student receives a unique SSH key pair.
- Access to the cluster goes through the Azure Jump Host (NSG-restricted).
- K3s join token is kept on the master and used for worker enrollment.

