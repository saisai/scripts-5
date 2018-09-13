#!/bin/bash

################################################
# Script Name   : net_scan.sh
# Description   : Track used IP addresses
# Args          : N/A
# Author        : Ary Kleinerman
# Email         : kleinerman@gmail.com
################################################

# Network to scan
NETWORK="172.22.100.0/22"

# File to keep IPs track
IPLIST=/root/net-scan.txt

# Scan the network
SCAN=`nmap -sn ${NETWORK} | grep "Nmap scan report" | egrep -o '([0-9]+\.){3}[0-9]+'`

# Add new IPs found in the scan
for IP in ${SCAN}; do
    if ! grep ${IP} ${IPLIST} > /dev/null 2>&1; then
        echo ${IP} >> ${IPLIST};
    fi;
done

# Sort the file by IP
sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 -o $IPLIST $IPLIST

