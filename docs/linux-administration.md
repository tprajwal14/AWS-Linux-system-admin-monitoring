# Linux System Administration

## Overview

This document describes the Linux System Administration activities
performed on the Ubuntu Linux server running on AWS EC2.

The project covers user and group management, file permissions,
SSH administration, Nginx administration, process monitoring,
disk and memory management, network troubleshooting, and log analysis.

---

## 1. System Information

The project server runs:

```text
Operating System:
Ubuntu Linux

Cloud Platform:
AWS EC2
```

Basic system information was checked using:

```bash
whoami
hostname
pwd
ls
ls -la
cat /etc/os-release
uname -a
```

These commands were used to identify the logged-in user,
hostname, working directory, operating system, and system details.

---

## 2. User Management

Two Linux users were created:

```text
prajwal
tejas
```

### Create Users

```bash
sudo adduser prajwal
sudo adduser tejas
```

### Verify Users

```bash
id prajwal
id tejas
```

---

## 3. Group Management

A common administrative group was created:

```text
sysadmin
```

### Create Group

```bash
sudo groupadd sysadmin
```

### Add Users to Group

```bash
sudo usermod -aG sysadmin prajwal
sudo usermod -aG sysadmin tejas
```

### Verify Group Membership

```bash
groups prajwal
groups tejas
getent group sysadmin
```

Using a common group provides a simple way to manage access
for multiple users.

---

## 4. File Ownership and Permissions

Linux file ownership and permissions were configured as part
of access-control practice.

### File Ownership

The `chown` command was used to assign ownership.

Example:

```bash
sudo chown prajwal:sysadmin <filename>
```

This sets:

```text
Owner:
prajwal

Group:
sysadmin
```

### File Permissions

The `chmod` command was used to control file access.

Example:

```bash
sudo chmod 640 <filename>
```

Permission:

```text
640

Owner  → Read + Write
Group  → Read
Others → No Access
```

### Verify

```bash
ls -l <filename>
```

Detailed permission configuration:

```text
configs/linux-permissions.txt
```

---

## 5. SSH Administration

SSH was used for secure remote administration of the Ubuntu
EC2 server.

### SSH Details

```text
Protocol:
SSH

Port:
22

User:
ubuntu

Authentication:
SSH Key Pair

Key Pair:
linux-admin-key
```

### Install OpenSSH Server

```bash
sudo apt update
sudo apt install openssh-server -y
```

### Service Management

Check:

```bash
sudo systemctl status ssh
```

Start:

```bash
sudo systemctl start ssh
```

Stop:

```bash
sudo systemctl stop ssh
```

Restart:

```bash
sudo systemctl restart ssh
```

Enable at boot:

```bash
sudo systemctl enable ssh
```

Check enabled status:

```bash
sudo systemctl is-enabled ssh
```

### Port Verification

```bash
sudo ss -tulpn | grep :22
```

SSH configuration details:

```text
configs/ssh-configuration.txt
```

---

## 6. Nginx Administration

Nginx was installed and configured as the web server on
the Ubuntu EC2 instance.

### Installation

```bash
sudo apt install nginx -y
```

### Service Management

```bash
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl status nginx
sudo systemctl enable nginx
sudo systemctl is-enabled nginx
```

### Configuration Validation

```bash
sudo nginx -t
```

A custom web page was configured under:

```text
/var/www/html
```

The web page was tested using the EC2 public IP.

### Nginx Logs

Access log:

```text
/var/log/nginx/access.log
```

Error log:

```text
/var/log/nginx/error.log
```

Nginx configuration:

```text
configs/nginx-server-config.conf
```

---

## 7. Process Management

Running Linux processes were inspected using:

```bash
ps
ps aux
ps -ef
top
```

### Activities

- Viewed running processes
- Checked active system processes
- Monitored system activity
- Investigated resource usage

---

## 8. Service Management

Linux services were managed using `systemctl`.

Examples:

```bash
sudo systemctl status nginx
sudo systemctl restart nginx
sudo systemctl enable nginx
```

Service logs were investigated using:

```bash
sudo journalctl -u nginx --no-pager -n 50
```

A Nginx service failure was simulated, investigated,
and the service was restored and verified.

---

## 9. Disk and Storage Management

Disk and filesystem usage were monitored using:

```bash
df -h
du -sh
lsblk
```

Root filesystem usage:

```bash
df -h /
```

Directory size analysis:

```bash
sudo du -sh /var/*
```

Log directory usage:

```bash
sudo du -sh /var/log/*
```

Block devices:

```bash
lsblk
```

These checks were used for disk capacity monitoring and
basic storage troubleshooting.

---

## 10. CPU and Memory Monitoring

System resource usage was checked using:

```bash
free -h
uptime
top
```

### Memory Monitoring

```bash
free -h
```

Used to review memory utilization.

### System Load and Uptime

```bash
uptime
```

Used to check server uptime and system load information.

### Real-Time Monitoring

```bash
top
```

Used to monitor processes and system activity.

---

## 11. Network Troubleshooting

Basic Linux network troubleshooting was performed using:

```bash
ip addr
ip route
ping
ss
```

### IP Address

```bash
ip addr
```

Used to inspect network interfaces and IP addresses.

### Routing

```bash
ip route
```

Used to inspect the routing table.

### Connectivity

```bash
ping -c 4 8.8.8.8
```

Used to test network connectivity.

### DNS / Hostname Resolution

```bash
ping -c 4 google.com
```

Used to test connectivity and hostname resolution.

### Listening Ports

```bash
ss -tulpn
```

Used to identify services listening on network ports.

---

## 12. Firewall Administration

Ubuntu UFW was used as the Linux host-level firewall.

Firewall rules were configured for required services.

Detailed firewall configuration:

```text
configs/ufw-rules.txt
```

---

## 13. Log Analysis

Logs were reviewed for monitoring and troubleshooting.

### Nginx Logs

```text
/var/log/nginx/access.log
/var/log/nginx/error.log
```

### System and Service Logs

```bash
journalctl
```

Example:

```bash
sudo journalctl -u nginx --no-pager -n 50
```

### Health Log

The server health-check script writes output to:

```text
/home/ubuntu/Linux-Project/health.log
```

View recent entries:

```bash
tail -20 /home/ubuntu/Linux-Project/health.log
```

Monitor in real time:

```bash
tail -f /home/ubuntu/Linux-Project/health.log
```

Logs were used to investigate service behavior,
errors, and system activity.

---

## 14. Shell Scripting

A server health-check script was created:

```text
server_health.sh
```

The script checks:

```text
Hostname
Uptime
Memory
Disk Usage
Nginx Status
```

### Execute Script

```bash
./server_health.sh
```

### Generate Health Report

```bash
./server_health.sh > server-health.txt
```

### Capture Output and Errors

```bash
./server_health.sh > server-health.txt 2>&1
```

The script provides a simple command-line method for
checking Linux server health.

---

## 15. Cron Automation

The health-check script was configured to run every 5 minutes.

Cron entry:

```bash
*/5 * * * * /home/ubuntu/Linux-Project/server_health.sh >> /home/ubuntu/Linux-Project/health.log 2>&1
```

### Verify Cron

```bash
crontab -l
```

### Automation Flow

```text
Cron
  |
  v
server_health.sh
  |
  ├── Hostname
  ├── Uptime
  ├── Memory
  ├── Disk Usage
  └── Nginx Status
  |
  v
health.log
```

This provides recurring automated health checks.

Detailed Cron configuration:

```text
configs/cron-job.txt
```

---

## 16. Linux Administration Workflow

The overall administration workflow used in the project:

```text
User / Group Management
          |
          v
File Ownership & Permissions
          |
          v
SSH Remote Administration
          |
          v
Nginx Service Management
          |
          v
Process & Resource Monitoring
          |
          v
Disk & Network Troubleshooting
          |
          v
Log Analysis
          |
          v
Shell Script
          |
          v
Cron Automation
```

---

## 17. Troubleshooting Approach

A systematic troubleshooting approach was followed:

```text
Issue
  |
  v
Check Service / Process
  |
  v
Validate Configuration
  |
  v
Check Logs
  |
  v
Check Network / Resources
  |
  v
Apply Resolution
  |
  v
Verify Recovery
```

This approach was applied to Nginx,
network connectivity, resource usage, logs,
and scheduled health-check activities.

---

## 18. Administration Outcome

This project provided hands-on experience with:

- Ubuntu Linux administration
- User and group management
- File ownership and permissions
- SSH remote administration
- Nginx administration
- Linux service management
- Process monitoring
- Disk and memory monitoring
- Network troubleshooting
- Firewall administration
- Log analysis
- Shell scripting
- Cron automation

The Linux server was also integrated with AWS CloudWatch
for centralized resource monitoring and alerting.
