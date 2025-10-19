#!/usr/bin/env bash
set -euo pipefail
ansible -i ansible/hosts.ini all -m ping
