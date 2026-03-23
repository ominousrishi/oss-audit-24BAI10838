#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: [Your Name] | Reg No: [Your Registration Number]
# Course: Open Source Software | Chosen Software: Git
# Description: Reads a log file line by line, counts occurrences
#              of a keyword (default: "error"), prints a summary,
#              and shows the last 5 matching lines.
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error
# ============================================================

# --- Accept command-line arguments ---
# $1 = path to the log file (required)
# $2 = keyword to search for (optional, defaults to "error")
LOGFILE=$1
KEYWORD=${2:-"error"}   # Default keyword is 'error' if none provided

COUNT=0                 # Counter variable to track keyword matches

echo "============================================================"
echo "           LOG FILE ANALYZER                               "
echo "============================================================"
echo ""

# --- Validate that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  [ERROR] No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo ""
    exit 1
fi

# --- do-while style retry: check if file exists, retry up to 3 times ---
# Bash doesn't have a native do-while, so we simulate it with a while loop
ATTEMPTS=0
MAX_ATTEMPTS=3

while [ ! -f "$LOGFILE" ] && [ $ATTEMPTS -lt $MAX_ATTEMPTS ]; do
    ATTEMPTS=$((ATTEMPTS + 1))
    echo "  [ATTEMPT $ATTEMPTS/$MAX_ATTEMPTS] File not found: $LOGFILE"

    if [ $ATTEMPTS -lt $MAX_ATTEMPTS ]; then
        # Prompt user to provide a different path
        read -rp "  Enter a valid log file path (or press Enter to abort): " NEW_PATH

        # If user pressed Enter without typing, break the retry loop
        if [ -z "$NEW_PATH" ]; then
            echo "  Aborted by user."
            exit 1
        fi

        LOGFILE="$NEW_PATH"   # Update the path with what the user provided
    fi
done

# --- Final check after retry loop ---
if [ ! -f "$LOGFILE" ]; then
    echo ""
    echo "  [ERROR] Could not find a valid log file after $MAX_ATTEMPTS attempts."
    echo "  Exiting."
    exit 1
fi

# --- Check if the file is empty ---
if [ ! -s "$LOGFILE" ]; then
    echo "  [WARNING] The file '$LOGFILE' is empty. Nothing to analyze."
    exit 0
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD'"
echo ""
echo "------------------------------------------------------------"
echo "  Scanning file line by line..."
echo "------------------------------------------------------------"
echo ""

# --- while read loop: read the file one line at a time ---
# IFS= ensures leading/trailing whitespace is preserved in each line
# -r prevents backslash interpretation
while IFS= read -r LINE; do

    # --- if-then: check if the current line contains the keyword (case-insensitive) ---
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))    # Increment counter for each matching line
    fi

done < "$LOGFILE"    # Redirect file content into the while loop

# --- Print summary result ---
echo "  RESULT: Keyword '$KEYWORD' was found $COUNT time(s) in:"
echo "          $LOGFILE"
echo ""

# --- Show last 5 matching lines using grep + tail ---
# This gives context for what the most recent matches looked like
echo "------------------------------------------------------------"
echo "  LAST 5 MATCHING LINES (most recent occurrences):"
echo "------------------------------------------------------------"
echo ""

MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

if [ -n "$MATCHES" ]; then
    # Print each of the last 5 matching lines with a line prefix
    echo "$MATCHES" | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
else
    echo "  [INFO] No matching lines found to display."
fi

echo ""
echo "============================================================"
echo "  Tip: Open-source tools like grep, awk, and sed — all     "
echo "  GPL-licensed — make log analysis powerful and free.      "
echo "============================================================"
