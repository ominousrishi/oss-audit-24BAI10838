#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: [Your Name] | Reg No: [Your Registration Number]
# Course: Open Source Software | Chosen Software: Git
# Description: Displays a welcome-style system identity report
#              showing OS details, user info, uptime, and the
#              open-source license covering the OS.
# ============================================================

# --- Student Info Variables ---
STUDENT_NAME="[Rishi Pandey]"          # Replace with your actual name
REG_NUMBER="[24BAI10838]"      # Replace with your registration number
SOFTWARE_CHOICE="Git"               # The open-source software chosen for audit

# --- Gather System Information using command substitution ---
KERNEL=$(uname -r)                  # Kernel version (e.g. 5.15.0-91-generic)
USER_NAME=$(whoami)                 # Current logged-in username
HOME_DIR=$HOME                      # Home directory of the current user
UPTIME=$(uptime -p)                 # Human-readable uptime (e.g. up 2 hours, 5 minutes)
DATETIME=$(date '+%A, %d %B %Y — %I:%M %p')   # Formatted current date and time

# --- Detect Linux Distribution Name ---
# /etc/os-release is a standard file present on most modern Linux distros
if [ -f /etc/os-release ]; then
    DISTRO=$(grep -w "PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"')
else
    DISTRO="Unknown Linux Distribution"
fi

# --- OS License Information ---
# The Linux kernel and most GNU/Linux distributions are released under GPL v2
OS_LICENSE="GNU General Public License v2 (GPL v2)"

# --- Display the System Identity Report ---
echo "============================================================"
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT         "
echo "============================================================"
echo ""
echo "  Student   : $STUDENT_NAME ($REG_NUMBER)"
echo "  Software  : $SOFTWARE_CHOICE (under audit)"
echo ""
echo "------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged User  : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  System Time  : $DATETIME"
echo "  Uptime       : $UPTIME"
echo ""
echo "------------------------------------------------------------"
echo "  LICENSE INFORMATION"
echo "------------------------------------------------------------"
echo "  The operating system running this audit is covered under:"
echo "  $OS_LICENSE"
echo ""
echo "  This means you are free to:"
echo "    [1] Run the OS for any purpose"
echo "    [2] Study and modify its source code"
echo "    [3] Redistribute copies of the OS"
echo "    [4] Distribute your modified versions"
echo ""
echo "============================================================"
echo "  Open Source: built openly, shared freely, improved by all."
echo "============================================================"
