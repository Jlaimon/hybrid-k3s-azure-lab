#!/usr/bin/env bash
set -euo pipefail

echo "[K3s] Uninstalling from master and workers..."
ansible -i ansible/hosts.ini master -b -m shell -a "/usr/local/bin/k3s-uninstall.sh || true"
ansible -i ansible/hosts.ini worker -b -m shell -a "/usr/local/bin/k3s-agent-uninstall.sh || true"

echo "[Docker] Optionally remove Docker (comment out to use)"
# ansible -i ansible/hosts.ini all -b -m apt -a "name=docker-ce state=absent purge=yes"
