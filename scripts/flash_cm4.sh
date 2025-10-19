#!/usr/bin/env bash
set -euo pipefail

echo "=== Flash Raspberry Pi CM4 with Raspberry Pi OS (64-bit) ==="
echo "This script documents the steps. Use Raspberry Pi Imager or rpiboot as needed."

echo "1) Put CM4 into USB boot mode (nRPIBoot) on DeskPi Super6C."
echo "2) Connect CM4 #1 USB to your PC via USB-C."
echo "3) Use Raspberry Pi Imager to flash Raspberry Pi OS (64-bit)."
echo "4) Press CTRL+SHIFT+X in Imager to preconfigure hostname, user, password, and enable SSH."
echo "5) After flash, edit 'boot/cmdline.txt' to set static IP if required:"
echo "   ip=192.168.137.11::192.168.137.1:255.255.255.0::eth0:off"
echo "Repeat for nodes .12 ... .16"
