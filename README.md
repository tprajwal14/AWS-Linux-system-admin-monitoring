# AWS Linux System Administration & Monitoring

> Hands-on AWS Linux administration project focused on server management, monitoring, troubleshooting, automation, and operational practices using Ubuntu EC2.

---

## 🚀 Project Overview

This project demonstrates practical Linux System Administration on an **Ubuntu Linux server hosted on AWS EC2**.

The environment was configured and managed with a focus on:

- Linux user and group administration
- File ownership and permissions
- SSH access and security
- Nginx web server administration
- UFW firewall configuration
- Process and service management
- Disk, memory, CPU, and network monitoring
- Linux log analysis and troubleshooting
- Shell scripting
- Cron-based automation
- AWS CloudWatch monitoring
- CloudWatch alarms and SNS email notifications
- IAM role-based AWS access
- Amazon S3 log/report storage
- AWS CLI
- Git and GitHub

---

## 🏗️ Architecture

```text
                              AWS
                               │
                       ┌───────▼────────┐
                       │   EC2 Instance │
                       │   Ubuntu Linux │
                       └───────┬────────┘
                               │
        ┌──────────────────────┼─────────────────────────┐
        │                      │                         │
       SSH                   Nginx              Linux Administration
        │                      │                         │
       UFW                  Web Logs              Users & Groups
                               │                  Permissions
                               │                  Processes
                               │                  Services
                               │                  Disk Management
                               │                  Networking
                               │                  Log Analysis
                               │                  Shell Scripting
                               │                  Cron
                               │
                               ▼
                       Server Health Script
                        server_health.sh
                               │
                               ▼
                         health.log
                               │
                               ├───────────────┐
                               │               │
                               ▼               ▼
                        CloudWatch Agent      AWS CLI
                               │               │
                    ┌──────────┼──────────┐    ▼
                    │          │          │   Amazon S3
                   CPU        RAM        Disk   │
                    │          │          │     ├── health-reports/
                    └──────────┼──────────┘     └── logs/
                               │
                               ▼
                        CloudWatch Metrics
                               │
                               ▼
                        CloudWatch Alarms
                               │
                               ▼
                          SNS Topic
                               │
                               ▼
                         Email Alerts



# AWS Linux System Administration & Monitoring Project

## Project Overview

A practical AWS-based Linux System Administration and Monitoring project built on Ubuntu Linux EC2.

## Architecture

EC2 Ubuntu Server
        |
        +-- Linux Administration
        +-- Nginx
        +-- SSH
        +-- UFW Firewall
        +-- Process & Service Management
        +-- Disk & Network Monitoring
        +-- Shell Scripting
        +-- Cron
        +-- CloudWatch
        +-- S3
        +-- Git & GitHub

## Technologies

- AWS EC2
- Ubuntu Linux
- IAM
- AWS CloudWatch
- CloudWatch Agent
- Amazon S3
- AWS CLI
- Nginx
- SSH
- UFW
- Systemd
- Shell Scripting
- Cron
- Git
- GitHub

## Linux Administration

- User and Group Management
- File Permissions and Ownership
- Process Management
- Service Management using systemd
- SSH Administration
- Disk Usage Monitoring
- Network Troubleshooting
- Log Analysis
- UFW Firewall Configuration
- Nginx Administration

## Monitoring

Configured CloudWatch Agent to collect:

- CPU metrics
- Memory utilization
- Disk utilization

Created CloudWatch monitoring and alarms for server resource utilization.

## Automation

Created a Shell script to check:

- Hostname
- Uptime
- Memory
- Disk Usage
- Nginx Status

Configured Cron to execute the health-check script every 5 minutes.

## AWS S3 Integration

Uploaded Linux server health reports and logs to Amazon S3 using AWS CLI and EC2 IAM role-based access.

## Git and GitHub

Git is used for version control and GitHub is used to maintain and showcase the project repository.

## Project Objective

To demonstrate practical experience in Linux System Administration, AWS infrastructure, monitoring, troubleshooting, automation, and basic DevOps practices.
