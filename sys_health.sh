#!/bin/bash

# sys_health.sh - A script to check system health

# Memory usage checker

echo "---SYSTEM HEALTH REPORT---"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
echo "$TIMESTAMP"

echo "---MEMORY REPORT---"

SYS_MEM=$(free -m | awk '/Mem:/{print $3}')
SYS_MEM_TOTAL=$(free -m | awk '/Mem:/{print $2}')
Used_MEM_Percent=$(( (SYS_MEM) * 100 / SYS_MEM_TOTAL ))


echo "Total Memory : $SYS_MEM_TOTAL"
echo "Used Memory : $SYS_MEM MB"
echo "Used Memory Percentage : $Used_MEM_Percent%"

if [ "$Used_MEM_Percent" -gt 70 ];
then
echo "WARNING! HIGH MEMORY USAGE."
else
echo "Memory under limit - GOOD HEALTH"
fi

# Disk Usage checker

echo "---DISK REPORT---"

TOTAL_Disk=$(df /mnt/c/ | grep -v Filesystem | awk '{print $2}')
USED_Disk=$(df /mnt/c/ | grep -v Filesystem | awk '{print $3}')
TOTAL_Disk_H=$(df -h /mnt/c/ | grep -v Filesystem | awk '{print $2}')
USED_Disk_H=$(df -h /mnt/c/ | grep -v Filesystem | awk '{print $3}')
Used_D_Percent=$(((USED_Disk) * 100 / TOTAL_Disk))

echo "Total Disk Space : $TOTAL_Disk_H"
echo "Used Disk Space : $USED_Disk_H"
echo "Used Disk Percentage : $Used_D_Percent"

if [ "$Used_D_Percent" -gt 60 ];
then
echo "HIGH DISK USAGE"
else
echo "Healthy disk usage"
fi

# Load Average checker

echo "---UPTIME REPORT---"

LOAD_Avg=$(uptime | awk -F'load average: ' '{print $2}')
UP_time=$(uptime | awk '{print $3}' | sed 's/,//')

echo "Current LOAD AVERAGE: $LOAD_Avg"
echo "UPTIME : $UP_time"
