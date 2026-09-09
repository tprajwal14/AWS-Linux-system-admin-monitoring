# 🚀 AWS Linux System Administration & Monitoring

> **Hands-on AWS + Linux project demonstrating server administration, security, monitoring, troubleshooting, automation, and operational practices using Ubuntu EC2.**

---

## 📌 Project Overview

This project demonstrates practical **Linux System Administration on an Ubuntu EC2 server hosted on AWS**.

The environment was configured and managed to simulate day-to-day responsibilities of a **Linux System Administrator / AWS Cloud Support / Junior DevOps Engineer**, including:

- Linux user and group administration
- File ownership and permissions
- SSH-based remote administration
- Nginx web server management
- UFW firewall configuration
- Process and systemd service management
- Disk, memory, CPU, and network monitoring
- Linux and application log analysis
- Shell scripting
- Cron-based automation
- AWS CloudWatch monitoring
- CloudWatch alarms and SNS email notifications
- IAM role-based AWS access
- Amazon S3 report and log storage
- AWS CLI
- Git and GitHub

---

# 🏗️ Solution Architecture

```text
                                      ☁️ AWS
                                        │
                           ┌────────────▼────────────┐
                           │      EC2 Instance       │
                           │       Ubuntu Linux      │
                           └────────────┬────────────┘
                                        │
              ┌─────────────────────────┼─────────────────────────┐
              │                         │                         │
              ▼                         ▼                         ▼
        🔐 SSH Access             🌐 Nginx Web Server       🐧 Linux Admin
              │                         │                         │
              ▼                         ▼                         ├── Users & Groups
        🔥 UFW Firewall            Nginx Logs                   ├── Permissions
        │                         access.log                     ├── Processes
        │                         error.log                      ├── Services
        │                                                           ├── Disk
        │                                                           ├── Networking
        │                                                           └── Troubleshooting
        │
        └──────────────────────────────┐
                                       ▼
                              🐚 server_health.sh
                                       │
                                       ▼
                              ⏰ Cron - Every 5 Min
                                       │
                                       ▼
                                  health.log
                                       │
                  ┌────────────────────┴────────────────────┐
                  │                                         │
                  ▼                                         ▼
        📊 CloudWatch Monitoring                     ☁️ Amazon S3
                  │                                         │
           CloudWatch Agent                        ┌────────┴────────┐
                  │                                 │                 │
        ┌─────────┼─────────┐                       ▼                 ▼
        ▼         ▼         ▼              health-reports/         logs/
       CPU       RAM       Disk                    │                 │
        │         │         │                     ▼                 ▼
        └─────────┼─────────┘             server-health.txt     health.log
                  │
                  ▼
           CloudWatch Metrics
                  │
                  ▼
          🚨 CloudWatch Alarms
                  │
                  ▼
              📢 SNS Topic
                  │
                  ▼
            📧 Email Alerts


                    EC2
                     │
                     ▼
                  IAM Role
                     │
          ┌──────────┴───────────┐
          ▼                      ▼
   CloudWatch Access          S3 Access
