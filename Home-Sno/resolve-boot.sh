#!/bin/bash

# Simple script to set DNS configuration on boot
cat > /etc/resolv.conf <<'CONFIG'
search example.com
nameserver 192.168.0.100
nameserver 8.8.8.8
nameserver 8.8.4.4
CONFIG

echo "DNS configured successfully on $(date)" >> /root/home-dns/dns-setup.log
