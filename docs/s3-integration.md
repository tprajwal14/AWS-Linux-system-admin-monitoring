# Amazon S3 Integration

## Overview

I integrated Amazon S3 with my Ubuntu EC2 server to store Linux server health reports and operational logs.

I used AWS CLI from the EC2 instance to upload the generated files to an S3 bucket.

---

## S3 Architecture

```text
                 Ubuntu EC2
                     |
          ┌──────────┴──────────┐
          |                     |
          v                     v
server-health.txt           health.log
          |                     |
          └──────────┬──────────┘
                     |
                     v
                  AWS CLI
                     |
                     v
              Amazon S3 Bucket
                     |
          ┌──────────┴──────────┐
          |                     |
          v                     v
   health-reports/           logs/
          |                     |
          v                     v
server-health.txt           health.log
```

---

## S3 Bucket

I created the following S3 bucket:

```text
prajwal-linux-admin-monitoring-2026
```

The objects are organized using S3 prefixes:

```text
prajwal-linux-admin-monitoring-2026/
│
├── health-reports/
│   └── server-health.txt
│
└── logs/
    └── health.log
```

---

## IAM Role

The EC2 instance uses the following IAM role:

```text
EC2-CloudWatch-Agent-Role
```

The role includes the required permissions for CloudWatch monitoring and S3 operations from the EC2 instance.

Detailed IAM configuration:

```text
configs/iam-permissions.md
```

---

## Health Report Generation

I generated the server health report using the Shell script:

```text
server_health.sh
```

The script checks:

- Hostname
- Uptime
- Memory
- Disk Usage
- Nginx Status

To save the script output to a report file:

```bash
./server_health.sh > server-health.txt
```

To capture both standard output and errors:

```bash
./server_health.sh > server-health.txt 2>&1
```

---

## Upload Health Report to S3

From the `Linux-Project` directory, I uploaded the report using:

```bash
aws s3 cp server-health.txt \
s3://prajwal-linux-admin-monitoring-2026/health-reports/
```

This stores the report under:

```text
health-reports/server-health.txt
```

---

## Upload Health Log to S3

The Cron job generates the local health log:

```text
health.log
```

I uploaded the log to S3 using:

```bash
aws s3 cp health.log \
s3://prajwal-linux-admin-monitoring-2026/logs/
```

This stores the log under:

```text
logs/health.log
```

---

## Verify S3 Objects

I verified the uploaded objects using:

```bash
aws s3 ls s3://prajwal-linux-admin-monitoring-2026/ --recursive
```

Expected structure:

```text
health-reports/server-health.txt
logs/health.log
```

To check object metadata:

```bash
aws s3api head-object \
--bucket prajwal-linux-admin-monitoring-2026 \
--key health-reports/server-health.txt
```

---

## Cron and S3 Relationship

Cron is configured to run the health-check script every 5 minutes:

```text
*/5 * * * * /home/ubuntu/Linux-Project/server_health.sh >> /home/ubuntu/Linux-Project/health.log 2>&1
```

The Cron job automatically:

```text
Cron
  |
  v
server_health.sh
  |
  v
health.log
```

The current Cron configuration does **not** automatically upload the files to S3.

The S3 upload is performed separately using AWS CLI:

```text
Linux Server
     |
     v
AWS CLI
     |
     v
Amazon S3
```

---

## S3 Storage Workflow

```text
                EC2 Ubuntu
                    |
          ┌─────────┴─────────┐
          |                   |
          v                   v
  server-health.txt       health.log
          |                   |
          └─────────┬─────────┘
                    |
                    v
                 AWS CLI
                    |
                    v
                 S3 Bucket
                    |
          ┌─────────┴─────────┐
          |                   |
          v                   v
   health-reports/          logs/
          |                   |
          v                   v
server-health.txt         health.log
```

---

## S3 Commands Used

### Check AWS CLI

```bash
aws --version
```

### List Accessible S3 Buckets

```bash
aws s3 ls
```

### Upload Files

```bash
aws s3 cp <file> s3://<bucket>/<path>/
```

### List Objects

```bash
aws s3 ls s3://<bucket>/ --recursive
```

### Check Object Metadata

```bash
aws s3api head-object \
--bucket <bucket> \
--key <object-key>
```

---

## Security Considerations

- EC2 uses an IAM role for AWS access.
- Long-term AWS access keys are not stored in the project.
- Private SSH keys are not uploaded to GitHub.
- Passwords and tokens are not stored in this documentation.
- The S3 bucket is used for project data storage and operational reports.

---

## Result

Through this integration, I practiced using AWS CLI with Amazon S3 from an Ubuntu EC2 server.

I stored:

```text
server-health.txt
health.log
```

in separate S3 prefixes for health reports and logs.

This demonstrates practical experience with:

- Amazon S3
- AWS CLI
- IAM role-based access
- Linux health reports
- Log storage
- EC2-to-S3 integration