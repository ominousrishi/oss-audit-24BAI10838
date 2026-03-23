#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: [Your Name] | Reg No: [Your Registration Number]
# Course: Open Source Software | Chosen Software: Git
# Description: Loops through key system directories and reports
#              permissions, ownership, and disk usage for each.
#              Also checks Git's configuration directory.
# ============================================================

# --- List of important system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share/doc/git")

echo "============================================================"
echo "          DISK AND PERMISSION AUDITOR                      "
echo "============================================================"
echo ""
echo "  Scanning key system directories..."
echo ""
printf "  %-25s %-25s %-10s\n" "Directory" "Owner  Group  Perms" "Size"
echo "  ---------------------------------------------------------------"

# --- For loop: iterate over each directory in the DIRS array ---
for DIR in "${DIRS[@]}"; do

    if [ -d "$DIR" ]; then
        # Extract permission string, owner, and group using ls -ld and awk
        # awk '{print $1}' gives permission bits (e.g. drwxr-xr-x)
        # awk '{print $3}' gives owner username
        # awk '{print $4}' gives group name
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # du -sh gives human-readable size; cut -f1 extracts just the size value
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        printf "  %-25s %-8s %-8s %-10s %-10s\n" "$DIR" "$OWNER" "$GROUP" "$PERMS" "${SIZE:-N/A}"
    else
        # Directory does not exist on this system — print a clear message
        printf "  %-25s %s\n" "$DIR" "[does not exist on this system]"
    fi

done

echo ""
echo "------------------------------------------------------------"
echo "  GIT CONFIGURATION DIRECTORY CHECK"
echo "------------------------------------------------------------"

# --- Check Git's user-level config directory (our chosen software) ---
# Git stores global config in ~/.gitconfig and local config in .git/ inside repos
GIT_GLOBAL_CONFIG="$HOME/.gitconfig"
GIT_SYSTEM_CONFIG="/etc/gitconfig"

echo ""
echo "  Checking Git configuration files..."
echo ""

# Check user-level global git config
if [ -f "$GIT_GLOBAL_CONFIG" ]; then
    PERMS=$(ls -l "$GIT_GLOBAL_CONFIG" | awk '{print $1}')
    OWNER=$(ls -l "$GIT_GLOBAL_CONFIG" | awk '{print $3}')
    SIZE=$(du -sh "$GIT_GLOBAL_CONFIG" 2>/dev/null | cut -f1)
    echo "  [FOUND]  ~/.gitconfig"
    echo "           Owner: $OWNER | Permissions: $PERMS | Size: $SIZE"
else
    echo "  [INFO]   ~/.gitconfig not found — Git may not be configured globally yet."
    echo "           Run: git config --global user.name 'Your Name'"
    echo "                git config --global user.email 'you@example.com'"
fi

echo ""

# Check system-level git config
if [ -f "$GIT_SYSTEM_CONFIG" ]; then
    PERMS=$(ls -l "$GIT_SYSTEM_CONFIG" | awk '{print $1}')
    OWNER=$(ls -l "$GIT_SYSTEM_CONFIG" | awk '{print $3}')
    echo "  [FOUND]  /etc/gitconfig (system-wide)"
    echo "           Owner: $OWNER | Permissions: $PERMS"
else
    echo "  [INFO]   /etc/gitconfig not found (system-wide config absent — this is normal)."
fi

echo ""
echo "  NOTE: Git's permission model matters for security."
echo "  Config files should be owned by the current user"
echo "  and not world-writable (avoid permissions like 777)."
echo ""
echo "============================================================"
