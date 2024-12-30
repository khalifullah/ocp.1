#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

set -e  # Exit on any command failure

echo "Starting OpenShift Cluster Setup on Bastion Node..."

# Step 1: Git Installation and Repository Cloning
echo "Step 1: Installing Git and cloning repository..."
yum install -y git
if git clone https://github.com/khalifullah/ocp.1.git; then
  cd /root/ocp.1/offical || exit
else
  echo "Failed to clone the repository. Exiting..."
  exit 1
fi

# Step 2: HAProxy Configuration
echo "Step 2: Installing and configuring HAProxy..."
dnf install haproxy -y
systemctl enable haproxy
rm -rf /etc/haproxy/haproxy.cfg
cp -v haproxy.cfg /etc/haproxy/haproxy.cfg

# Step 3: DHCP Configuration
echo "Step 3: Installing and configuring DHCP server..."
dnf install dhcp-server -y
systemctl enable dhcpd.service
rm -rf /etc/dhcp/dhcpd.conf
cp -v dhcpd.conf /etc/dhcp/

# Step 4: Named (DNS) Configuration
echo "Step 4: Installing and configuring Bind (DNS)..."
dnf install bind bind-utils -y
systemctl enable named
rm -rf /etc/named.conf
cp -v named.conf /etc/
mkdir -p /var/named/chroot/var/named/
cp -v 172.40.20.rev /var/named/chroot/var/named/
cp -v vcenterlocalhost.com.txt /var/named/chroot/var/named/vcenterlocalhost.com
chmod 777 /var/named/chroot/var/named/*

# Step 5: Apache HTTPD Configuration
echo "Step 5: Installing and configuring Apache HTTPD..."
yum install httpd -y
systemctl enable httpd.service
sed -i 's/^Listen 80$/Listen 8080/' /etc/httpd/conf/httpd.conf

# Step 6: SSH Key Generation
echo "Step 6: Generating SSH keys..."
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

# Step 7: Preparing OpenShift Configuration
echo "Step 7: Preparing OpenShift installation configuration..."
mkdir -p /root/ocp4/
if [ -f /root/ocp.1/offical/install-config.yaml ]; then
  cp -v /root/ocp.1/offical/install-config.yaml /root/ocp4/
else
  echo "Error: install-config.yaml not found. Please ensure it exists in /root/ocp.1/offical/"
  exit 1
fi

# Verify the status of services
echo "Verifying service statuses..."
for service in haproxy dhcpd named httpd; do
  if systemctl is-enabled --quiet $service; then
    echo "$service is enabled."
  else
    echo "Error: $service is not enabled. Check the configuration for details."
  fi
done

echo "OpenShift Bastion Node Setup Completed Successfully!"
