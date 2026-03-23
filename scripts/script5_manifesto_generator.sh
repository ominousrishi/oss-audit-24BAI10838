#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author: [Your Name] | Reg No: [Your Registration Number]
# Course: Open Source Software | Chosen Software: Git
# Description: Asks the user three interactive questions and
#              generates a personalised open-source philosophy
#              statement, saving it to a .txt file.
# Concepts: read, string concatenation, file redirection (>),
#           date command, alias concept (shown via comment).
# ============================================================

# --- Alias concept demonstrated ---
# In a real shell session you might define:
#   alias today='date "+%d %B %Y"'
# Here we use a variable to achieve the same readable result:
TODAY=$(date '+%d %B %Y')          # e.g. 15 June 2024
OUTPUT_FILE="manifesto_$(whoami).txt"   # Output filename includes the username

echo "============================================================"
echo "       OPEN SOURCE MANIFESTO GENERATOR                     "
echo "============================================================"
echo ""
echo "  This tool will create a personalised open-source"
echo "  philosophy statement based on your answers."
echo ""
echo "  Answer three short questions below."
echo ""
echo "------------------------------------------------------------"

# --- Interactive input using 'read' ---
# -p flag shows the prompt inline; input is stored in the named variable

read -rp "  1. Name one open-source tool you use every day: " TOOL

# Validate that the user actually typed something
while [ -z "$TOOL" ]; do
    echo "     [Please enter at least one word]"
    read -rp "  1. Name one open-source tool you use every day: " TOOL
done

echo ""
read -rp "  2. In one word, what does 'freedom' mean to you in tech? " FREEDOM

while [ -z "$FREEDOM" ]; do
    echo "     [Please enter at least one word]"
    read -rp "  2. In one word, what does 'freedom' mean to you in tech? " FREEDOM
done

echo ""
read -rp "  3. Name one thing you would build and share freely: " BUILD

while [ -z "$BUILD" ]; do
    echo "     [Please enter at least one word]"
    read -rp "  3. Name one thing you would build and share freely: " BUILD
done

echo ""
echo "------------------------------------------------------------"
echo "  Generating your manifesto..."
echo "------------------------------------------------------------"
echo ""

# --- Build the manifesto using string concatenation and heredoc ---
# We use > to create/overwrite the file, then >> to append additional lines

# Write the header to the output file (> creates or overwrites)
echo "============================================================" > "$OUTPUT_FILE"
echo "           MY OPEN SOURCE MANIFESTO                        " >> "$OUTPUT_FILE"
echo "    Generated on $TODAY by $(whoami)                       " >> "$OUTPUT_FILE"
echo "============================================================" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# --- Compose and write the personalised philosophy paragraph ---
# String concatenation: variables are embedded directly inside double-quoted strings

echo "Every day, I rely on $TOOL — a tool built not for profit," >> "$OUTPUT_FILE"
echo "but for people. Its existence reminds me that some of the" >> "$OUTPUT_FILE"
echo "most powerful things in technology were given away freely," >> "$OUTPUT_FILE"
echo "by people who believed that $FREEDOM matters more than" >> "$OUTPUT_FILE"
echo "lock-in, patents, or paywalls." >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "I believe in the open-source way. If I were to build" >> "$OUTPUT_FILE"
echo "$BUILD, I would share it. Not because I have to, but" >> "$OUTPUT_FILE"
echo "because the tools I use every day exist because someone" >> "$OUTPUT_FILE"
echo "before me made that same choice. Standing on the shoulders" >> "$OUTPUT_FILE"
echo "of giants means carrying the ladder forward — releasing" >> "$OUTPUT_FILE"
echo "your work so the next person climbs higher than you did." >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "Open source is not a license model. It is a philosophy:" >> "$OUTPUT_FILE"
echo "that knowledge shared is knowledge multiplied, and that" >> "$OUTPUT_FILE"
echo "the best software is built when no one owns the problem." >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "  — $(whoami) | $TODAY" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "============================================================" >> "$OUTPUT_FILE"

# --- Display success message and print the manifesto ---
echo "  [SUCCESS] Manifesto saved to: $OUTPUT_FILE"
echo ""
echo "------------------------------------------------------------"
echo "  YOUR MANIFESTO:"
echo "------------------------------------------------------------"
echo ""

# cat prints the file content to the terminal
cat "$OUTPUT_FILE"
