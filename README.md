# Project: Command-Line System Health Monitoring Script

> A lightweight, portable Bash script that generates a real-time health and status report for any Linux system.

This project was developed as a practical exercise to master foundational command-line skills, including system command execution, text processing, and conditional logic. It serves as a genuinely useful utility for any engineer or system administrator who needs a quick, at-a-glance overview of a machine's vital signs.

## Overview

In any computing environment, from a personal development machine to a production cloud server, the ability to quickly assess system health is a critical first step in troubleshooting and performance monitoring. While complex monitoring suites exist, a simple, universal script that provides a quick snapshot of core metrics is an invaluable tool for initial diagnostics.

This script, `sys_health.sh`, solves this problem. It runs on any standard Linux system and generates a clean, human-readable report covering memory usage, disk capacity, and system load, along with simple status checks to highlight potential issues.

## Features

* **Comprehensive Reporting:** Gathers and displays key system metrics in three main categories: Memory, Disk, and System Load.
* **Human-Readable Output:** Formats raw system data into a clean, easy-to-read report with clear labels and units (MB, G, %).
* **Automated Health Checks:** Implements conditional logic to check if memory and disk usage exceed predefined thresholds, printing a clear "OK" or "WARNING" status.
* **Portable & Dependency-Free:** Written in pure Bash and uses only standard, universally available Linux command-line utilities (`df`, `free`, `uptime`, `awk`, `sed`), making it instantly usable on almost any Linux server.

## Prerequisites

This script is designed to run in a standard Linux/Unix-like environment (including WSL) and relies on the following common utilities:
* `bash`
* `df`
* `free`
* `uptime`
* `awk`
* `sed`
* `date`

## Usage

1.  **Make the script executable:**
    Before its first use, you must give the script execute permissions.
    ```bash
    chmod +x sys_health.sh
    ```

2.  **Run the script:**
    Execute the script from your terminal. If your system requires it for certain commands, it may prompt for your `sudo` password.
    ```bash
    ./sys_health.sh
    ```

### Example Output

Running the script will produce a report similar to the following:


--- SYSTEM HEALTH REPORT ---
14:30:00 IST 2025

--- MEMORY REPORT ---
Total Memory: 7785MB
Used Memory : 2150MB (27%)
Status      : Memory under limit - GOOD HEALTH

--- DISK REPORT ---
Total Disk Space: 477G
Used Disk Space : 275G (57%)
Status          : Healthy disk usage

--- UPTIME REPORT ---
Uptime       : 1h25m
Load Average : 0.00, 0.00, 0.00
--- END OF REPORT ---


## How It Works

The script operates by executing standard Linux commands and then piping their output through a series of text-processing tools to extract and format the required information.

1.  **Memory & Disk Usage:**
    * The script runs `free -m` (for memory) and `df -h` (for disk).
    * The output is piped to `awk 'NR==2 {print $...}'` to select the specific data row, avoiding the header.
    * Values are stored in variables, and a percentage is calculated using Bash's arithmetic expansion `((...))`.

2.  **System Load & Uptime:**
    * The `uptime` command is executed.
    * The output is parsed using `awk` with a custom field separator (`-F'load average: '`) to reliably extract the load average numbers.
    * Another `awk` and `sed` combination is used to extract and clean up the system uptime duration.

3.  **Conditional Health Checks:**
    * The script uses `if [ "$VAR" -gt THRESHOLD ]; then ... fi` blocks to compare the calculated memory and disk usage percentages against predefined thresholds (e.g., 70% for memory).
    * Based on this comparison, it prints a user-friendly status message, such as "GOOD HEALTH" or "WARNING! HIGH USAGE."

