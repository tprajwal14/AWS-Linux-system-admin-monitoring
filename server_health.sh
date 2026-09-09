#!/bin/bash

echo "================================"
echo "     SERVER HEALTH CHECK"
echo "================================"

echo ""
echo "Hostname:"
hostname

echo ""
echo "Uptime:"
uptime

echo ""
echo "Memory:"
free -h

echo ""
echo "Disk Usage:"
df -h /

echo ""
echo "Nginx Status:"
systemctl is-active nginx

echo ""
echo "================================"
