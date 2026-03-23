#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: [Your Name] | Reg No: [Your Registration Number]
# Course: Open Source Software | Chosen Software: Git
# Description: Checks if the chosen FOSS package is installed,
#              prints its version and license, and uses a case
#              statement to display a philosophy note per package.
# ============================================================

# --- Package to inspect (our chosen software for the audit) ---
PACKAGE="git"   # Change this if your chosen software differs

echo "============================================================"
echo "          FOSS PACKAGE INSPECTOR                           "
echo "============================================================"
echo ""

# --- Detect package manager and check if package is installed ---
# Different distros use different package managers (apt vs rpm)
# We try both to make the script portable across Debian and RHEL systems

INSTALLED=false
VERSION="Unknown"
LICENSE_INFO="Unknown"
SUMMARY="Unknown"

if command -v dpkg &>/dev/null; then
    # --- Debian/Ubuntu path: use dpkg and apt-cache ---
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        INSTALLED=true
        VERSION=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii" | awk '{print $3}')
        LICENSE_INFO=$(apt-cache show "$PACKAGE" 2>/dev/null | grep -i "^license\|^License" | head -1)
        SUMMARY=$(apt-cache show "$PACKAGE" 2>/dev/null | grep "^Description-en\|^Description:" | head -1 | sed 's/^Description[^:]*: //')
    fi
elif command -v rpm &>/dev/null; then
    # --- RHEL/CentOS/Fedora path: use rpm -qi ---
    if rpm -q "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        VERSION=$(rpm -qi "$PACKAGE" | grep "^Version" | awk '{print $3}')
        LICENSE_INFO=$(rpm -qi "$PACKAGE" | grep "^License" | awk -F: '{print $2}' | xargs)
        SUMMARY=$(rpm -qi "$PACKAGE" | grep "^Summary" | awk -F: '{print $2}' | xargs)
    fi
fi

# --- Print installation status ---
if [ "$INSTALLED" = true ]; then
    echo "  [FOUND]   '$PACKAGE' is INSTALLED on this system."
    echo ""
    echo "  Version   : $VERSION"
    echo "  License   : ${LICENSE_INFO:-See package documentation}"
    echo "  Summary   : ${SUMMARY:-See package documentation}"
else
    echo "  [MISSING] '$PACKAGE' is NOT installed on this system."
    echo ""
    echo "  To install it, run:"
    echo "    On Ubuntu/Debian : sudo apt install $PACKAGE"
    echo "    On RHEL/Fedora   : sudo dnf install $PACKAGE"
fi

echo ""
echo "------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "------------------------------------------------------------"

# --- Case statement: prints a philosophy note based on the package name ---
# Each entry reflects a key idea from that project's open-source story
case $PACKAGE in
    git)
        echo "  Git: Born from necessity when Linus Torvalds refused"
        echo "  to let proprietary tools control Linux development."
        echo "  Git is freedom — every clone is a full backup."
        ;;
    httpd | apache2)
        echo "  Apache: The web server that made the internet open."
        echo "  A collaborative patch project that outgrew its origins"
        echo "  and now powers nearly 30% of all websites globally."
        ;;
    mysql | mariadb)
        echo "  MySQL: Open source at the heart of millions of apps."
        echo "  Its dual-license story teaches us that even open tools"
        echo "  can become battlegrounds for corporate control."
        ;;
    vlc)
        echo "  VLC: Built by students in Paris who just wanted to"
        echo "  stream video on a campus network. It plays anything"
        echo "  because no format should be locked behind a paywall."
        ;;
    firefox)
        echo "  Firefox: A nonprofit's answer to browser monopoly."
        echo "  Mozilla proved that a community can build world-class"
        echo "  software driven by values, not venture capital."
        ;;
    python3 | python)
        echo "  Python: Shaped entirely by community consensus and"
        echo "  PEPs (Python Enhancement Proposals). A language where"
        echo "  readability and openness are core design values."
        ;;
    libreoffice)
        echo "  LibreOffice: Born from a community fork of OpenOffice"
        echo "  when Oracle's stewardship felt threatening. A lesson"
        echo "  that open licenses protect communities, not just code."
        ;;
    *)
        echo "  '$PACKAGE': Every open-source tool carries a story of"
        echo "  someone who chose to share rather than sell. That"
        echo "  choice built the internet as we know it."
        ;;
esac

echo ""
echo "============================================================"
