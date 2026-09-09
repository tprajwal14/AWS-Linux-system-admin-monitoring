# IAM Permissions

## EC2 IAM Role

The Ubuntu EC2 instance uses a single IAM role for AWS service access.

**IAM Role:**

`EC2-CloudWatch-Agent-Role`

The role is attached to the EC2 instance using:

**EC2 → Actions → Security → Modify IAM role**

---

## Attached Permissions

The following AWS managed policies are attached to the role:

### 1. CloudWatchAgentServerPolicy

**Purpose:**

Provides the permissions required by the Amazon CloudWatch Agent to publish Linux system monitoring metrics to CloudWatch.

### Monitoring

- CPU metrics
- Memory utilization
- Disk utilization

---

### 2. AmazonS3FullAccess

**Purpose:**

Provides S3 permissions required for the AWS CLI operations used in this project.

### S3 Usage

S3 is used to store:

```text
health-reports/
└── server-health.txt

logs/
└── health.log
