हो 👍 तुझ्या **AWS EC2 Ubuntu Linux System Administration & Monitoring** project साठी `docs/troubleshooting.md` तयार करूया. यात तू project मध्ये केलेले actual troubleshooting scenarios — Nginx, networking, disk/memory, services, logs आणि CloudWatch Agent — professional first-person style मध्ये दाखवू शकतेस.

# Linux Server Troubleshooting

## Overview

I performed Linux server troubleshooting on my Ubuntu EC2 instance as part of my AWS Linux System Administration and Monitoring project.

I used Linux commands, system logs, service management, network troubleshooting, and AWS monitoring tools to identify and resolve common infrastructure issues.

---

## Troubleshooting Approach

I followed a structured troubleshooting process:

```text
Issue
  |
  v
Check Service Status
  |
  v
Check Logs
  |
  v
Check Configuration
  |
  v
Check Network / Resources
  |
  v
Apply Fix
  |
  v
Restart / Reload Service
  |
  v
Verify
```

---

## 1. Nginx Service Troubleshooting

### Issue

I simulated an Nginx service failure by stopping the Nginx service.

```bash
sudo systemctl stop nginx
```

I verified the service status:

```bash
sudo systemctl status nginx
```

The service was shown as inactive.

### Troubleshooting

I checked the Nginx service status:

```bash
systemctl is-active nginx
```

I checked the Nginx configuration:

```bash
sudo nginx -t
```

Expected successful output:

```text
syntax is ok
test is successful
```

I also checked the Nginx error log:

```bash
sudo tail -n 50 /var/log/nginx/error.log
```

### Resolution

After verifying the configuration, I started Nginx:

```bash
sudo systemctl start nginx
```

I verified the service:

```bash
sudo systemctl status nginx
```

I also verified that Nginx was active:

```bash
systemctl is-active nginx
```

Expected:

```text
active
```

### Verification

I verified that the web service was listening on port 80:

```bash
sudo ss -tulpn | grep :80
```

---

## 2. Nginx Log Analysis

I used Nginx logs to troubleshoot web-server related issues.

### Error Log

```bash
sudo tail -n 50 /var/log/nginx/error.log
```

### Access Log

```bash
sudo tail -n 50 /var/log/nginx/access.log
```

I used log entries to identify service events, requests, and possible errors.

A notice-level message such as:

```text
using inherited sockets
```

was treated as an informational message rather than a service failure.

---

## 3. Network Troubleshooting

I used standard Linux networking commands to troubleshoot connectivity.

### Check IP Address

```bash
ip addr
```

This helped me verify the network interfaces and assigned IP addresses.

### Check Routing Table

```bash
ip route
```

I used the routing table to verify the default gateway and available network routes.

### Test Connectivity

```bash
ping -c 4 8.8.8.8
```

I used this to test basic IP connectivity.

### Check Listening Ports

```bash
sudo ss -tulpn
```

This helped me identify services listening on TCP and UDP ports.

---

## 4. UFW Firewall Troubleshooting

I configured UFW firewall rules for required services.

I checked the firewall status:

```bash
sudo ufw status
```

I allowed SSH:

```bash
sudo ufw allow 22/tcp
```

I allowed HTTP:

```bash
sudo ufw allow 80/tcp
```

I allowed HTTPS:

```bash
sudo ufw allow 443/tcp
```

I enabled UFW:

```bash
sudo ufw enable
```

I verified the rules:

```bash
sudo ufw status
```

The required ports were allowed before enabling the firewall to avoid losing SSH access.

---

## 5. Disk Usage Troubleshooting

I checked root filesystem usage using:

```bash
df -h /
```

This helped me identify the amount of used and available disk space.

For detailed filesystem information:

```bash
df -h
```

I used disk usage information to determine whether storage capacity could affect system services.

---

## 6. Memory Troubleshooting

I checked memory usage using:

```bash
free -h
```

This displayed total, used, free, and available memory.

I also monitored memory usage through the CloudWatch Agent.

The custom CloudWatch namespace used in the project is:

```text
Linux/EC2
```

The memory metric collected was:

```text
mem_used_percent
```

---

## 7. CPU Troubleshooting

I checked system CPU and process activity using:

```bash
top
```

I also used:

```bash
uptime
```

to review system load and uptime information.

For AWS monitoring, I used the EC2 CPU utilization metric:

```text
CPUUtilization
```

---

## 8. System Service Troubleshooting

I used `systemctl` to troubleshoot Linux services.

Check service status:

```bash
sudo systemctl status nginx
```

Start a service:

```bash
sudo systemctl start nginx
```

Stop a service:

```bash
sudo systemctl stop nginx
```

Restart a service:

```bash
sudo systemctl restart nginx
```

Enable a service at boot:

```bash
sudo systemctl enable nginx
```

Check whether a service is active:

```bash
systemctl is-active nginx
```

---

## 9. Cron Troubleshooting

The health-check script was configured to run every five minutes:

```text
*/5 * * * * /home/ubuntu/Linux-Project/server_health.sh >> /home/ubuntu/Linux-Project/health.log 2>&1
```

I checked the generated log:

```bash
cat ~/Linux-Project/health.log
```

I also used Cron service logs for troubleshooting:

```bash
sudo journalctl -u cron -n 50
```

The `-u` option requires a service name. Therefore, running only:

```bash
sudo journalctl -u
```

results in an error because the unit/service name is missing.

---

## 10. Shell Script Troubleshooting

My server health script is:

```text
/home/ubuntu/Linux-Project/server_health.sh
```

I verified the file:

```bash
ls -l ~/Linux-Project/server_health.sh
```

I verified that the script has execute permission:

```bash
chmod +x ~/Linux-Project/server_health.sh
```

I executed the script:

```bash
./server_health.sh
```

The script checks:

- Hostname
- Uptime
- Memory
- Disk Usage
- Nginx Status

I redirected the output to a report file when required:

```bash
./server_health.sh > server-health.txt 2>&1
```

---

## 11. CloudWatch Agent Troubleshooting

While configuring the CloudWatch Agent, the agent initially failed to publish metrics because the EC2 instance did not have the required IAM role.

The log showed credential-related errors such as:

```text
NoCredentialProviders: no valid providers in chain
```

and:

```text
EC2RoleRequestError: no EC2 instance role found
```

### Root Cause

The EC2 instance did not have an IAM role attached that provided the required CloudWatch permissions.

### Resolution

I created and attached the IAM role:

```text
EC2-CloudWatch-Agent-Role
```

The role included:

```text
CloudWatchAgentServerPolicy
```

I then restarted the CloudWatch Agent:

```bash
sudo systemctl restart amazon-cloudwatch-agent
```

I verified the service:

```bash
sudo systemctl status amazon-cloudwatch-agent
```

The agent started successfully and reached the ready state.

The agent log showed:

```text
Everything is ready. Begin running and processing data.
```

This confirmed that the CloudWatch Agent was running correctly.

---

## 12. CloudWatch Agent Log Troubleshooting

I used the CloudWatch Agent log to investigate errors:

```bash
sudo grep -iE "error|fail" /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log
```

For recent log entries:

```bash
sudo tail -n 50 /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log
```

This helped me identify credential, configuration, and service startup issues.

---

## 13. AWS CLI / S3 Troubleshooting

I used AWS CLI from the Ubuntu EC2 instance for S3 operations.

I checked AWS CLI:

```bash
aws --version
```

I checked accessible S3 buckets:

```bash
aws s3 ls
```

I verified S3 objects:

```bash
aws s3 ls s3://prajwal-linux-admin-monitoring-2026/ --recursive
```

I used IAM role-based access instead of storing long-term AWS access keys on the EC2 server.

---

## 14. General Troubleshooting Commands

The following commands were useful throughout the project:

### Service Status

```bash
systemctl status <service>
```

### Service Logs

```bash
journalctl -u <service>
```

### Recent Logs

```bash
journalctl -n 50
```

### Process Monitoring

```bash
top
```

### Memory

```bash
free -h
```

### Disk

```bash
df -h
```

### Network Interfaces

```bash
ip addr
```

### Routing

```bash
ip route
```

### Listening Ports

```bash
ss -tulpn
```

### Connectivity

```bash
ping -c 4 8.8.8.8
```

---

## Troubleshooting Summary

| IssueInvestigationResolution |                                 |                                       |
| ---------------------------- | ------------------------------- | ------------------------------------- |
| Nginx inactive               | `systemctl status nginx`        | Started Nginx                         |
| Nginx configuration          | `nginx -t`                      | Verified configuration                |
| Nginx logs                   | `tail /var/log/nginx/error.log` | Analyzed log entries                  |
| Network connectivity         | `ip addr`, `ip route`, `ping`   | Verified network configuration        |
| Firewall                     | `ufw status`                    | Configured required ports             |
| Disk usage                   | `df -h`                         | Monitored filesystem usage            |
| Memory usage                 | `free -h`                       | Monitored memory                      |
| Cron                         | `journalctl -u cron`            | Checked scheduled-job execution       |
| CloudWatch Agent             | Agent logs                      | Attached IAM role and restarted agent |
| S3                           | AWS CLI commands                | Verified bucket and objects           |

---

## Result

Through this project, I practiced structured Linux server troubleshooting across services, networking, storage, memory, firewall, automation, AWS monitoring, and S3 integration.

I used a combination of:

- Linux commands
- `systemctl`
- `journalctl`
- Nginx logs
- UFW
- Shell scripting
- Cron
- AWS CLI
- IAM
- CloudWatch Agent
- Amazon CloudWatch
- Amazon S3

This helped me develop practical troubleshooting skills for AWS cloud infrastructure, Linux system administration, and production support environments.

### 🟢 File तयार करण्यासाठी

```bash
cd ~/Linux-Project
mkdir -p docs
nano docs/troubleshooting.md
```

वरचा content paste कर → **Ctrl+O → Enter → Ctrl+X**

मग:

```bash
git add docs/troubleshooting.md
git commit -m "Add Linux troubleshooting documentation"
git push origin main
```

यामुळे `docs/troubleshooting.md` तुझ्या GitHub repository मध्ये जाईल.



me write kele as batl pahije ...ani .md file de