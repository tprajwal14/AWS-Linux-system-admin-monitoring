# 🚀 AWS Linux System Administration & Monitoring

> **Hands-on AWS + Linux project demonstrating server administration, security, monitoring, troubleshooting, automation, and operational practices using Ubuntu EC2.**

---

## 📌 Project Overview

This project demonstrates practical **Linux System Administration on an Ubuntu Linux server hosted on Amazon EC2**.

The environment was configured and managed to simulate real-world day-to-day responsibilities of a:

* Linux System Administrator
* AWS Cloud Support Engineer
* Junior DevOps Engineer

### Key Areas Covered

* Linux user and group administration
* File ownership and permissions
* SSH-based remote administration
* Nginx web server management
* UFW firewall configuration
* Process and systemd service management
* CPU, memory, disk, and network monitoring
* Linux and application log analysis
* Shell scripting
* Cron-based automation
* AWS CloudWatch monitoring
* CloudWatch Agent
* CloudWatch Metrics
* CloudWatch Alarms
* IAM role-based AWS access
* Amazon S3 report and log storage
* AWS CLI
* Git and GitHub

---

# 🏗️ Solution Architecture

```text
                         ☁️ AWS
                           │
                           ▼
                  ┌──────────────────┐
                  │   Amazon EC2     │
                  │   Ubuntu Linux   │
                  └────────┬─────────┘
                           │
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
     🔐 SSH Access    🌐 Nginx        🐧 Linux Admin
          │                │                │
          ▼                ▼                ├── Users & Groups
     🔥 UFW Firewall   Nginx Logs          ├── Permissions
                                            ├── Processes
                                            ├── Services
                                            ├── Disk
                                            ├── Networking
                                            └── Troubleshooting
                           │
                           ▼
                  🐚 server_health.sh
                           │
                           ▼
                    ⏰ Cron - Every 5 Min
                           │
                           ▼
                      health.log
                           │
             ┌─────────────┴─────────────┐
             │                           │
             ▼                           ▼
      📊 CloudWatch                 ☁️ Amazon S3
             │                           │
      CloudWatch Agent             health-reports/
             │                           │
      ┌──────┼──────┐                    └── logs/
      ▼      ▼      ▼
     CPU    RAM    Disk
      │      │      │
      └──────┼──────┘
             ▼
      CloudWatch Metrics
             │
             ▼
      CloudWatch Alarms
```

---

# ☁️ AWS Services

| AWS Service            | Purpose                                       |
| ---------------------- | --------------------------------------------- |
| **Amazon EC2**         | Host the Ubuntu Linux server                  |
| **AWS IAM**            | Provide role-based permissions to EC2         |
| **Amazon CloudWatch**  | Monitor server performance                    |
| **CloudWatch Agent**   | Collect CPU, memory, and disk metrics         |
| **CloudWatch Metrics** | Store and visualize monitoring data           |
| **CloudWatch Alarms**  | Trigger alerts based on configured thresholds |
| **Amazon S3**          | Store health reports and logs                 |
| **AWS CLI**            | Manage AWS resources from the Linux server    |

---

# 🐧 Linux / Ubuntu Administration

## Operating System

* Ubuntu Linux

## User Management

The project covers basic Linux user administration, including:

* User creation
* User verification
* User and group administration

Common commands:

```bash
adduser
id
groups
```

## Group Management

```bash
groupadd
usermod
groups
```

## Sudo / Privilege Management

Administrative privileges can be configured using the appropriate Linux groups.

Example:

```bash
sudo usermod -aG sudo username
```

## File & Directory Management

Common commands used:

```bash
mkdir
ls
ls -la
cp
cat
nano
```

## File Ownership

```bash
chown
```

Example:

```bash
sudo chown username:group filename
```

## File Permissions

```bash
chmod
```

Example:

```bash
chmod 640 filename
```

---

# 🔐 SSH Remote Administration

SSH was used to remotely access and administer the Ubuntu EC2 server.

### Key Concepts

* SSH login
* `.pem` key authentication
* SSH connectivity
* Port 22
* Secure remote administration

Example:

```bash
ssh -i linux-admin-key.pem ubuntu@PUBLIC-IP
```

> **Note:** Replace `linux-admin-key.pem` and `PUBLIC-IP` with your actual key file and EC2 public IP address.

---

# ⚙️ Process Management

Linux processes were monitored and investigated using:

```bash
ps
ps aux
ps -ef
top
```

These commands help identify:

* Running processes
* CPU-consuming processes
* Memory-consuming processes
* Process IDs
* Process states

---

# 🔄 Service Management / systemd

The Nginx service was managed using `systemctl`.

```bash
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl status nginx
sudo systemctl enable nginx
sudo systemctl is-enabled nginx
```

Service failure scenarios were also considered for troubleshooting practice.

---

# 🌐 Nginx Web Server

Nginx was installed and configured as a web server on the Ubuntu EC2 instance.

### Activities

* Nginx installation
* Nginx service management
* Custom web page configuration
* Configuration validation
* Log analysis

Test Nginx configuration:

```bash
sudo nginx -t
```

### Nginx Logs

```text
/var/log/nginx/access.log
/var/log/nginx/error.log
```

Useful commands:

```bash
tail
journalctl
```

---

# 🔥 UFW Firewall

UFW was configured as the Linux host-based firewall.

```bash
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable
sudo ufw status
```

### Ports

| Port    | Purpose |
| ------- | ------- |
| **22**  | SSH     |
| **80**  | HTTP    |
| **443** | HTTPS   |

> AWS Security Groups should also be configured appropriately because UFW and AWS Security Groups operate at different network layers.

---

# 🌐 Network Troubleshooting

Network configuration and connectivity were checked using:

```bash
ip addr
ip route
ping
ss
```

Examples:

```bash
ping -c 4 8.8.8.8
ping -c 4 google.com
ss -tulpn
```

These commands help troubleshoot:

* IP configuration
* Routing
* Internet connectivity
* Listening ports
* Active network connections

---

# 💾 Disk & Storage Management

Disk and storage utilization were monitored using:

```bash
df -h
du -sh
lsblk
```

Root filesystem check:

```bash
df -h /
```

These commands help identify:

* Disk utilization
* Large directories
* Mounted filesystems
* Available storage
* Block devices

---

# 🧠 CPU & Memory Monitoring

System resource usage was checked using:

```bash
free -h
uptime
top
```

The monitoring focuses on:

* CPU utilization
* Memory utilization
* System uptime
* Running processes
* System load

---

# 📋 Log Analysis

The project includes practical log analysis of:

* Nginx access logs
* Nginx error logs
* System logs
* Cron output
* Server health logs

Useful commands:

```bash
tail
cat
journalctl
```

Example:

```bash
sudo tail -f /var/log/nginx/error.log
```

---

# 🐚 Shell Scripting

The main server health-check script is:

```text
server_health.sh
```

The script checks important server health information such as:

* Hostname
* Uptime
* Memory usage
* Disk usage
* Nginx service status

Make the script executable:

```bash
chmod +x server_health.sh
```

Run manually:

```bash
./server_health.sh
```

---

# ⏰ Cron Automation

The health-check script is scheduled to run every **5 minutes** using Cron.

Example:

```cron
*/5 * * * * /home/ubuntu/Linux-Project/server_health.sh >> /home/ubuntu/Linux-Project/health.log 2>&1
```

### Purpose

The automated job:

1. Executes every 5 minutes
2. Checks server health
3. Appends output to `health.log`
4. Captures errors using `2>&1`

Check configured Cron jobs:

```bash
crontab -l
```

---

# 📊 AWS CloudWatch Monitoring

The **Amazon CloudWatch Agent** is configured on the Ubuntu EC2 instance to collect additional system-level metrics.

### Metrics Collected

* CPU
* Memory
* Disk

### CloudWatch Namespace

```text
Linux/EC2
```

### Collection Interval

```text
60 seconds
```

### CPU Metrics

```text
cpu_usage_idle
cpu_usage_user
cpu_usage_system
```

### Memory Metric

```text
mem_used_percent
```

### Disk Metric

```text
disk_used_percent
```

CloudWatch provides centralized visibility into the server's resource utilization.

---

# 🚨 CloudWatch Alarms

The project includes monitoring plans/configuration for:

```text
Linux-Server-High-CPU
Linux-Server-High-Memory
Linux-Server-High-Disk
```

Example threshold:

```text
80%
```

These alarms are intended to identify high resource utilization and support proactive server monitoring.

---

# 🔑 IAM Role

An IAM role was created for the EC2 instance:

```text
EC2-CloudWatch-Agent-Role
```

The role provides AWS permissions required by the EC2 server for CloudWatch monitoring and S3 operations.

Primary CloudWatch policy:

```text
CloudWatchAgentServerPolicy
```

The EC2 instance uses an IAM role instead of storing long-term AWS access keys on the server.

This follows a more secure approach for accessing AWS services from EC2.

---

# ☁️ Amazon S3

Amazon S3 is used to store generated health reports and log files.

### Bucket

```text
prajwal-linux-admin-monitoring-2026
```

### Structure

```text
prajwal-linux-admin-monitoring-2026/
│
├── health-reports/
│   └── server-health.txt
│
└── logs/
    └── health.log
```

### Upload Health Report

```bash
aws s3 cp server-health.txt \
s3://prajwal-linux-admin-monitoring-2026/health-reports/
```

### Upload Log

```bash
aws s3 cp health.log \
s3://prajwal-linux-admin-monitoring-2026/logs/
```

### Verify Objects

```bash
aws s3 ls s3://prajwal-linux-admin-monitoring-2026/ --recursive
```

---

# 🖥️ AWS CLI

AWS CLI was used from the Ubuntu EC2 server to interact with AWS services.

Commands used include:

```bash
aws --version
aws s3 ls
aws s3 cp
aws s3api head-object
```

AWS CLI allows AWS resources and services to be managed directly from the Linux command line.

---

# 📁 Project Structure

```text
AWS-Linux-system-admin-monitoring/
│
├── configs/
│   └── CloudWatch configuration files
│
├── docs/
│   └── Project documentation
│
├── screenshots/
│   └── AWS and Linux screenshots
│
├── server_health.sh
├── .gitignore
└── README.md
```

---

# 🔧 Commands & Tools Used

## Linux

```text
whoami
hostname
pwd
ls
ls -la
cat
cp
nano
apt
adduser
groupadd
usermod
id
groups
chown
chmod
ps
top
systemctl
journalctl
nginx
ip
ping
ss
df
du
lsblk
free
uptime
crontab
```

## AWS

```text
aws --version
aws s3 ls
aws s3 cp
aws s3api head-object
```

## Git

```text
git init
git add .
git commit
git branch
git remote
git push
```

---

# 🧪 Troubleshooting Areas Covered

The project provides hands-on practice with common Linux server issues.

## High CPU

```bash
top
ps aux
uptime
```

## High Memory

```bash
free -h
top
```

## Disk Full

```bash
df -h
du -sh
lsblk
```

## Nginx Issue

```bash
systemctl status nginx
nginx -t
journalctl
tail /var/log/nginx/error.log
```

## Network Issue

```bash
ip addr
ip route
ping
ss -tulpn
```

## Log Investigation

```bash
tail
cat
journalctl
```

---

# 📈 Monitoring Flow

```text
Ubuntu EC2
    │
    ▼
CloudWatch Agent
    │
    ├── CPU
    ├── Memory
    └── Disk
    │
    ▼
CloudWatch Metrics
    │
    ▼
CloudWatch Alarms
    │
    ▼
Resource Utilization Monitoring
```

---

# 📦 Report & Log Flow

```text
Ubuntu EC2
    │
    ▼
server_health.sh
    │
    ▼
Cron - Every 5 Minutes
    │
    ▼
health.log / server-health.txt
    │
    ▼
AWS CLI
    │
    ▼
Amazon S3
    │
    ├── health-reports/
    └── logs/
```

---

# 🔐 Security Practices

The project demonstrates basic server and cloud security practices:

* SSH key-based authentication
* UFW firewall configuration
* AWS Security Group awareness
* IAM role-based AWS access
* Least-privilege oriented AWS access
* Linux file ownership and permissions
* No hard-coded AWS credentials in scripts
* Controlled network ports
* Secure remote administration

---

# 🛠️ Technologies Used

| Category              | Technologies      |
| --------------------- | ----------------- |
| **Cloud**             | AWS               |
| **Compute**           | Amazon EC2        |
| **Operating System**  | Ubuntu Linux      |
| **Monitoring**        | Amazon CloudWatch |
| **Monitoring Agent**  | CloudWatch Agent  |
| **Storage**           | Amazon S3         |
| **Access Management** | AWS IAM           |
| **CLI**               | AWS CLI           |
| **Web Server**        | Nginx             |
| **Firewall**          | UFW               |
| **Automation**        | Cron              |
| **Scripting**         | Bash / Shell      |
| **Version Control**   | Git               |
| **Repository**        | GitHub            |

---

# 🎯 Skills Demonstrated

This project demonstrates practical skills in:

* Linux System Administration
* AWS EC2 Administration
* AWS IAM
* CloudWatch Monitoring
* Server Health Monitoring
* CPU / Memory / Disk Troubleshooting
* Nginx Administration
* SSH Administration
* Linux Firewall Management
* User & Group Management
* File Permissions
* Process Management
* systemd Service Management
* Network Troubleshooting
* Log Analysis
* Shell Scripting
* Cron Automation
* AWS CLI
* S3 Operations
* Git & GitHub

---

# 📸 Project Evidence

Screenshots and supporting documentation are maintained in:

```text
screenshots/
docs/
configs/
```

### Recommended Evidence

* EC2 instance
* IAM role
* CloudWatch Agent
* CloudWatch metrics
* CloudWatch alarms
* S3 bucket
* Linux users and groups
* File permissions
* Nginx configuration and status
* UFW configuration
* Cron configuration
* Server health script
* AWS CLI commands

---

# 👨‍💻 Project Author

**Prajwal Take**

GitHub:

```text
https://github.com/tprajwal14
```

---

# ⭐ Project Summary

> **An end-to-end hands-on AWS and Linux System Administration project covering EC2 server administration, security, Nginx, SSH, UFW, systemd, process management, disk and network troubleshooting, shell scripting, Cron automation, CloudWatch monitoring, IAM, S3, AWS CLI, Git, and GitHub.**

---

## 📌 Project Highlights

* ☁️ Deployed and administered an Ubuntu Linux server on AWS EC2
* 🐧 Performed practical Linux administration and troubleshooting
* 🔐 Implemented SSH access, Linux permissions, UFW, and IAM-based access
* 🌐 Installed and managed Nginx web server
* 📊 Configured CloudWatch monitoring for system resources
* 🚨 Created monitoring and alerting concepts using CloudWatch Alarms
* 🐚 Automated server health checks using Bash and Cron
* ☁️ Stored reports and logs in Amazon S3 using AWS CLI
* 📝 Maintained project documentation, configuration files, and evidence using Git/GitHub
