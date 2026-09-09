# AWS CloudWatch Monitoring

## Overview

I configured AWS CloudWatch to monitor my Ubuntu Linux EC2 server
and track CPU, memory, and disk utilization.

I installed and configured the CloudWatch Agent to collect Linux
system metrics every 60 seconds and publish them to the `Linux/EC2`
namespace.

---

## Monitoring Architecture

```text
                         AWS EC2
                            |
                            v
                     Ubuntu Linux
                            |
                            v
                   CloudWatch Agent
                            |
                +-----------+-----------+
                |           |           |
                v           v           v
               CPU        Memory       Disk
                |           |           |
                +-----------+-----------+
                            |
                            v
                    CloudWatch Metrics
                            |
             +--------------+--------------+
             |              |              |
             v              v              v
        CPU Alarm      Memory Alarm     Disk Alarm
             |              |              |
             +--------------+--------------+
                            |
                            v
                         SNS Topic
                            |
                            v
                       Email Alert
```

---

## IAM Role

I attached the following IAM role to my EC2 instance:

```text
EC2-CloudWatch-Agent-Role
```

The role has these permissions:

```text
CloudWatchAgentServerPolicy
AmazonS3FullAccess
```

`CloudWatchAgentServerPolicy` is used by the CloudWatch Agent
to publish Linux monitoring metrics to CloudWatch.

`AmazonS3FullAccess` is used for the S3 operations performed
from the EC2 instance using AWS CLI.

Detailed IAM information:

```text
configs/iam-permissions.md
```

---

## CloudWatch Agent

I installed the Amazon CloudWatch Agent on the Ubuntu EC2 server.

The configuration file used in the project is:

```text
configs/cloudwatch-agent.json
```

### Namespace

```text
Linux/EC2
```

### Collection Interval

```text
60 seconds
```

The agent collects operating-system-level CPU, memory,
and disk metrics.

---

## Metrics I Configured

### CPU

```text
cpu_usage_idle
cpu_usage_user
cpu_usage_system
```

### Memory

```text
mem_used_percent
```

### Disk

```text
disk_used_percent
```

The root filesystem is monitored:

```text
/
```

---

## CloudWatch Agent Management

I used the following commands to manage and verify the agent.

Check status:

```bash
sudo systemctl status amazon-cloudwatch-agent
```

Restart agent:

```bash
sudo systemctl restart amazon-cloudwatch-agent
```

Check agent logs:

```bash
sudo journalctl -u amazon-cloudwatch-agent --no-pager -n 50
```

---

# CloudWatch Alarms

I created **three CloudWatch alarms** for resource monitoring.

## 1. High CPU Alarm

Alarm Name:

```text
Linux-Server-High-CPU
```

Metric:

```text
CPUUtilization
```

Condition:

```text
Statistic: Average
Period: 5 minutes
Threshold: >= 80%
```

Purpose:

To detect high CPU utilization on the EC2 Linux server.

---

## 2. High Memory Alarm

Alarm Name:

```text
Linux-Server-High-Memory
```

Metric:

```text
mem_used_percent
```

Condition:

```text
Statistic: Average
Period: 5 minutes
Threshold: >= 80%
```

Purpose:

To detect high memory utilization on the Linux server.

---

## 3. High Disk Alarm

Alarm Name:

```text
Linux-Server-High-Disk
```

Metric:

```text
disk_used_percent
```

Condition:

```text
Statistic: Average
Period: 5 minutes
Threshold: >= 80%
```

Purpose:

To detect high root filesystem disk utilization.

---

## SNS Email Notification

I configured an SNS topic for CloudWatch alarm notifications.

Notification flow:

```text
CPU / Memory / Disk
        |
        v
CloudWatch Metric
        |
        v
CloudWatch Alarm
        |
        v
     SNS Topic
        |
        v
   Email Alert
```

This allows me to receive email notifications when the configured
resource thresholds are breached.

---

## Monitoring Verification

### Check CloudWatch Metrics

AWS Console:

```text
CloudWatch
   |
   v
Metrics
   |
   v
Linux/EC2
```

Metrics:

```text
cpu_usage_idle
cpu_usage_user
cpu_usage_system
mem_used_percent
disk_used_percent
```

### Check Alarms

AWS Console:

```text
CloudWatch
   |
   v
Alarms
   |
   v
All Alarms
```

Expected alarms:

```text
Linux-Server-High-CPU
Linux-Server-High-Memory
Linux-Server-High-Disk
```

---

## My Monitoring Workflow

```text
Ubuntu EC2
    |
    v
CloudWatch Agent
    |
    +---- CPU
    |
    +---- Memory
    |
    +---- Disk
    |
    v
CloudWatch Metrics
    |
    v
3 CloudWatch Alarms
    |
    v
SNS Topic
    |
    v
Email Notification
```

---

## Result

Through this setup, I practiced configuring Linux server monitoring
using AWS CloudWatch, collecting CPU, memory, and disk metrics,
creating threshold-based alarms, and sending monitoring
notifications through SNS email alerts.

This project helped me build hands-on experience with:

- EC2 monitoring
- CloudWatch Agent
- Custom CloudWatch metrics
- CloudWatch Alarms
- SNS notifications
- IAM role-based AWS access
