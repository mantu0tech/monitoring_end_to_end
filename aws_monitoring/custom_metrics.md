Here is your updated **README.md section for LAB 5 – Custom Metrics using Script (Proper & Professional Version)** with multiple metric examples.

---

# 🧪 LAB 5: Create Custom Metrics in CloudWatch (Amazon Linux EC2)

---

# 🎯 Objective

* Launch Amazon Linux EC2
* Attach IAM Role with CloudWatch permissions
* Create a script to push custom metrics
* Send multiple custom metrics to CloudWatch
* Verify metrics in console

---

# 🪜 Step 1: Launch Amazon Linux Instance

1. Go to **EC2**
2. Click **Launch Instance**
3. Select **Amazon Linux 2**
4. Instance Type: `t2.micro`
5. Create or select key pair
6. Launch instance

---

# 🔐 Step 2: Attach IAM Role

Create IAM Role with:

### Required Policies:

* `CloudWatchAgentAdminPolicy`
* `CloudWatchAgentServerPolicy`

OR attach:

* `CloudWatchFullAccess` (for lab purpose only)

### Attach Role to EC2:

1. EC2 → Select Instance
2. Click **Actions**
3. Security → Modify IAM Role
4. Attach created role
5. Save

---

# 🖥 Step 3: Install CloudWatch Agent (Optional but Recommended)

```bash
sudo yum install amazon-cloudwatch-agent -y
```

---

# 📜 Step 4: Create Custom Metrics Script

```bash
vi custom_metrics.sh
```

Paste the following script:

```bash
#!/bin/bash

# Fetch Instance ID dynamically
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

NAMESPACE="demo_Metrics"

# 1️⃣ Memory Utilization %
MEMORY_UTILIZATION=$(free | grep Mem | awk '{printf "%.2f\n", $3/$2 * 100}')

# 2️⃣ CPU Utilization %
CPU_UTILIZATION=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

# 3️⃣ Disk Usage %
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# 4️⃣ Random Application Request Count (Example)
REQUEST_COUNT=$((RANDOM % 100))

# Send Memory Metric
aws cloudwatch put-metric-data \
  --metric-name "MemoryUtilization" \
  --namespace "$NAMESPACE" \
  --dimensions InstanceId=$INSTANCE_ID \
  --value "$MEMORY_UTILIZATION" \
  --unit Percent

# Send CPU Metric
aws cloudwatch put-metric-data \
  --metric-name "CustomCPUUtilization" \
  --namespace "$NAMESPACE" \
  --dimensions InstanceId=$INSTANCE_ID \
  --value "$CPU_UTILIZATION" \
  --unit Percent

# Send Disk Usage Metric
aws cloudwatch put-metric-data \
  --metric-name "DiskUsage" \
  --namespace "$NAMESPACE" \
  --dimensions InstanceId=$INSTANCE_ID \
  --value "$DISK_USAGE" \
  --unit Percent

# Send Request Count Metric
aws cloudwatch put-metric-data \
  --metric-name "RequestCount" \
  --namespace "$NAMESPACE" \
  --dimensions InstanceId=$INSTANCE_ID \
  --value "$REQUEST_COUNT" \
  --unit Count
```

---

# 🛠 Step 5: Give Execute Permission

```bash
chmod +x custom_metrics.sh
```

---

# ▶ Step 6: Run the Script

```bash
./custom_metrics.sh
```

If you get error:

* Check IAM role attached
* Check AWS CLI configured
* Check instance has internet access

---

# 📊 Step 7: Verify in CloudWatch

1. Go to **CloudWatch**
2. Click **Metrics**
3. Click **All Metrics**
4. Open Namespace → `demo_Metrics`

You should see:

* MemoryUtilization
* CustomCPUUtilization
* DiskUsage
* RequestCount

---
# 📌 Additional Custom Metric Examples (Manual Command)

### 1️⃣ API Request Count

```bash
aws cloudwatch put-metric-data \
  --namespace "demo_App" \
  --metric-name "APIRequestCount" \
  --unit Count \
  --value 5 \
  --dimensions APIName="UserCreate"
```

---

### 2️⃣ Active Users Metric

```bash
aws cloudwatch put-metric-data \
  --namespace "demo_App" \
  --metric-name "ActiveUsers" \
  --unit Count \
  --value 120 \
  --dimensions Environment="Production"
```

---

### 3️⃣ Application Error Count

```bash
aws cloudwatch put-metric-data \
  --namespace "demo_App" \
  --metric-name "ApplicationErrors" \
  --unit Count \
  --value 2 \
  --dimensions Service="PaymentService"
```

---

### 4️⃣ Queue Length Metric

```bash
aws cloudwatch put-metric-data \
  --namespace "demo_App" \
  --metric-name "QueueLength" \
  --unit Count \
  --value 15 \
  --dimensions QueueName="OrderQueue"
```

---

# 🧠 Important Interview Concepts

### Why Custom Metrics?

Because AWS does NOT provide:

* Memory usage (by default)
* Disk usage %
* Application-level metrics
* Business metrics

We push them manually using:

```
aws cloudwatch put-metric-data
```

---

# 🔥 Real-World Use Case

| Metric            | Why Important              |
| ----------------- | -------------------------- |
| MemoryUtilization | Prevent application crash  |
| DiskUsage         | Prevent disk full issue    |
| RequestCount      | Traffic monitoring         |
| ErrorCount        | Detect application failure |
| ActiveUsers       | Business analytics         |

---

# 🎯 Final Architecture

```
EC2 Instance
   ↓
Custom Script
   ↓
CloudWatch Custom Metrics
   ↓
Alarm (Optional)
   ↓
SNS Notification
```

---

