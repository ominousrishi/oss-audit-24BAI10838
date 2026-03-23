# OSS Audit — Git
### Open Source Software Capstone Project | VITyarthi

---

**Student Name:** [Rishi Pandey]  
**Registration Number:** [24BAI10838]  
**Chosen Software:** Git (Version Control System)  
**Course:** Open Source Software (NGMC)

---

## About This Project

This repository contains the five shell scripts submitted as part of the **Open Source Audit** capstone project. Each script demonstrates practical Linux and shell scripting skills while connecting to the philosophy and ecosystem of **Git** — the open-source version control system created by Linus Torvalds in 2005.

---

## Repository Structure

```
oss-audit-[rollnumber]/
│
├── README.md                          ← This file
│
└── scripts/
    ├── script1_system_identity.sh     ← Script 1: System Identity Report
    ├── script2_package_inspector.sh   ← Script 2: FOSS Package Inspector
    ├── script3_disk_auditor.sh        ← Script 3: Disk and Permission Auditor
    ├── script4_log_analyzer.sh        ← Script 4: Log File Analyzer
    └── script5_manifesto_generator.sh ← Script 5: Open Source Manifesto Generator
```

---

## Environment Setup

### Requirements

- A Linux system (Ubuntu 20.04+ / Debian / RHEL / Fedora / any modern distro)
- Bash shell (version 4.0 or higher — standard on all modern Linux)
- Git installed (`sudo apt install git` or `sudo dnf install git`)
- Basic utilities: `uname`, `whoami`, `du`, `df`, `ls`, `grep` (pre-installed on all Linux)

### Verify Bash version

```bash
bash --version
```

### Make all scripts executable

After cloning the repository, run this once to give all scripts execute permission:

```bash
chmod +x scripts/*.sh
```

---

## Scripts — Description and How to Run

---

### Script 1: System Identity Report

**File:** `scripts/script1_system_identity.sh`

**What it does:**  
Displays a formatted welcome screen showing the Linux distribution name, kernel version, current logged-in user, home directory, system uptime, current date/time, and the open-source license covering the OS.

**Concepts used:** Variables, `echo`, command substitution `$()`, `/etc/os-release` parsing, output formatting.

**How to run:**

```bash
bash scripts/script1_system_identity.sh
```

**Expected output:**  
A formatted system identity report printed to the terminal.

---

### Script 2: FOSS Package Inspector

**File:** `scripts/script2_package_inspector.sh`

**What it does:**  
Checks whether `git` (or any specified package) is installed on the system. Prints version, license, and summary information. Uses a `case` statement to display a philosophy note about each recognized open-source package.

**Concepts used:** `if-then-else`, `case` statement, `dpkg`/`rpm` package queries, pipe with `grep`.

**How to run:**

```bash
bash scripts/script2_package_inspector.sh
```

**To check a different package**, open the script and change the `PACKAGE` variable at the top:

```bash
PACKAGE="vlc"    # or firefox, python3, mysql, etc.
```

---

### Script 3: Disk and Permission Auditor

**File:** `scripts/script3_disk_auditor.sh`

**What it does:**  
Loops through a predefined list of important system directories (`/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`, and Git's doc directory) and reports the permissions, owner, group, and disk usage for each. Also checks for Git's global and system-level configuration files.

**Concepts used:** `for` loop, array iteration, `ls -ld`, `du -sh`, `awk`, `cut`, conditional directory checks.

**How to run:**

```bash
bash scripts/script3_disk_auditor.sh
```

**Note:** Some directories (like `/var/log`) may require `sudo` to get accurate sizes:

```bash
sudo bash scripts/script3_disk_auditor.sh
```

---

### Script 4: Log File Analyzer

**File:** `scripts/script4_log_analyzer.sh`

**What it does:**  
Accepts a log file path and an optional keyword as command-line arguments. Reads the file line by line using a `while read` loop, counts how many lines contain the keyword (case-insensitive), and prints a summary. Includes a retry mechanism if the file is not found, and displays the last 5 matching lines.

**Concepts used:** `while read` loop, `if-then`, counter variables, command-line arguments (`$1`, `$2`), `grep`, `tail`, retry loop simulation.

**How to run:**

```bash
# Basic usage — searches for "error" by default
bash scripts/script4_log_analyzer.sh /var/log/syslog

# With a custom keyword
bash scripts/script4_log_analyzer.sh /var/log/syslog "warning"

# On systems using journald (no /var/log/syslog), try:
bash scripts/script4_log_analyzer.sh /var/log/kern.log

# Create a test log file if needed
echo -e "INFO: system started\nERROR: disk full\nWARNING: low memory\nERROR: connection refused" > /tmp/test.log
bash scripts/script4_log_analyzer.sh /tmp/test.log error
```

---

### Script 5: Open Source Manifesto Generator

**File:** `scripts/script5_manifesto_generator.sh`

**What it does:**  
Interactively asks the user three questions, then composes a personalised open-source philosophy statement using their answers. Saves the result to a `.txt` file named `manifesto_<username>.txt` and prints it to the terminal.

**Concepts used:** `read` for interactive input, string concatenation, file redirection (`>` and `>>`), `date` command, alias concept (demonstrated via comment), input validation with `while`.

**How to run:**

```bash
bash scripts/script5_manifesto_generator.sh
```

Follow the three prompts. The manifesto will be saved as `manifesto_<yourusername>.txt` in the current directory.

---

## Dependencies

| Dependency | Purpose | Pre-installed? |
|------------|---------|----------------|
| `bash` | Run all scripts | Yes (all Linux) |
| `git` | Script 2 package check | Install if needed |
| `uname` | Kernel version (Script 1) | Yes |
| `whoami` | Username (Scripts 1, 5) | Yes |
| `dpkg` / `rpm` | Package info (Script 2) | Depends on distro |
| `du`, `ls`, `df` | Disk/permission info (Script 3) | Yes |
| `grep`, `tail` | Log analysis (Script 4) | Yes |
| `date` | Timestamp (Script 5) | Yes |

---

## Tested On

- Ubuntu 22.04 LTS (bash 5.1)
- Debian 11 (bash 5.1)
- Fedora 39 (bash 5.2)

---

## Academic Integrity

All scripts are original work written by the student listed above. They were developed, tested, and documented independently as part of the VITyarthi OSS Capstone Project.

---

*"Every tool you will use in your career was shaped by people who chose to build in the open and share their work freely."*  
— VITyarthi OSS Course
