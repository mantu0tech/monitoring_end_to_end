Here is your complete **README.md** file with explanations and practical step-by-step labs.

---

# 📘 AWS CloudWatch & Monitoring – Complete Guide with Practicals

---

# 1️⃣ What is Amazon CloudWatch?

Amazon **CloudWatch** is a monitoring and observability service in AWS.

It helps you:

* Monitor AWS resources (EC2, RDS, Lambda, etc.)
* Monitor applications
* Collect logs
* Create alarms
* Send notifications
* Track performance and health

CloudWatch collects:

* **Metrics** (numerical data like CPU usage)
* **Logs** (application/system logs)
* **Events**
* **Alarms**

---

# 2️⃣ What is a Dashboard?

A **CloudWatch Dashboard** is a customizable visual screen where you can see:

* Graphs of metrics
* Alarm status
* Logs insights
* Multiple services in one place

It gives a **single view of system health**.

Example:

* EC2 CPU usage graph
* Network traffic graph
* Alarm status widget

---

# 3️⃣ What are Metrics?

A **Metric** is a numerical measurement over time.

Examples:

* CPUUtilization
* NetworkIn
* NetworkOut
* DiskReadOps
* Memory usage (custom)

Each metric has:

* Namespace
* Dimensions
* Timestamp
* Value

Example:

```
CPUUtilization = 65%
Time = 10:05 AM
InstanceId = i-123456
```

---

# 4️⃣ What are Logs?

Logs are **records of events** from applications or systems.

Examples:

* Application errors
* Apache logs
* System boot logs
* Security logs

CloudWatch Logs allows:

* Store logs
* Search logs
* Filter logs
* Create alarms from logs

---

# 5️⃣ What is an Alarm?

A **CloudWatch Alarm** watches a metric and performs an action when threshold is crossed.

Example:

* If CPU > 80% for 5 minutes → Send notification

Actions:

* Send SNS notification
* Stop EC2
* Terminate EC2
* Auto Scaling action

---

# 6️⃣ What is SNS?

SNS (Simple Notification Service) is used to send:

* Email
* SMS
* Lambda trigger
* HTTP endpoint

CloudWatch Alarm → SNS → Email notification

---

# 7️⃣ What is Custom Metric?

By default, AWS provides basic metrics like:

* CPUUtilization
* NetworkIn
* DiskReadOps

But AWS does NOT provide:

* Memory usage
* Disk space %
* Application-specific data

👉 When we manually send our own metric to CloudWatch, it is called a **Custom Metric**.

---

## Example of Custom Metrics

| Custom Metric | Why Needed               |
| ------------- | ------------------------ |
| MemoryUsage   | Not available by default |
| DiskUsage     | Not available by default |
| ActiveUsers   | Application metric       |
| QueueLength   | App performance metric   |

---

# 8️⃣ What is CloudTrail?

CloudTrail records **who did what in AWS**.

Example:

* Who started EC2?
* Who deleted S3 bucket?
* Who changed IAM policy?

It records:

* API calls
* Console activity
* CLI activity

Used for:

* Auditing
* Security
* Compliance

---

# 🧪 PRACTICAL LAB – COMPLETE MONITORING SETUP

---

# LAB 1: Monitor EC2 Using CloudWatch Metrics

## Step 1: Launch EC2 Instance

1. Go to EC2
2. Click Launch Instance
3. Choose Amazon Linux 2
4. Instance type: t2.micro
5. Launch

---

## Step 2: View Default Metrics

1. Go to CloudWatch
2. Click Metrics
3. Click EC2
4. Click Per-Instance Metrics
5. Select CPUUtilization

You will see CPU graph.

---

# LAB 2: Create CloudWatch Dashboard

## Step 1:

1. Go to CloudWatch
2. Click Dashboards
3. Click Create Dashboard
4. Name: EC2-Monitoring

## Step 2:

1. Add Widget
2. Select Line Graph
3. Select EC2 → CPUUtilization
4. Add to dashboard
5. Save

Now you have a dashboard.

---

# LAB 3: Create Alarm + SNS Notification

## Step 1: Create SNS Topic

1. Go to SNS
2. Click Create Topic
3. Type: Standard
4. Name: EC2-Alerts
5. Create

## Step 2: Create Subscription

1. Click Create Subscription
2. Protocol: Email
3. Enter your email
4. Confirm from email

---

## Step 3: Create Alarm

1. Go to CloudWatch
2. Click Alarms → Create Alarm
3. Select Metric → EC2 → CPUUtilization
4. Condition:

   * Threshold: Greater than 70%
   * For 5 minutes
5. Action:

   * Send notification
   * Select SNS topic EC2-Alerts
6. Name: High-CPU-Alarm
7. Create

Now if CPU > 70% → Email sent.

---


---



# LAB 4: CloudTrail Setup

1. Go to CloudTrail
2. Click Create Trail
3. Name: MyTrail
4. Apply to all regions
5. Create

Now:

* Start/Stop EC2
* Create S3
* Modify IAM

Go to:
CloudTrail → Event History

You will see all activities.

---

# 🔥 Real-World Architecture Flow

```
EC2 Server
   ↓
CloudWatch Metrics
   ↓
Alarm
   ↓
SNS
   ↓
Email Notification

Logs → CloudWatch Logs
API Activity → CloudTrail
Custom App Data → Custom Metrics
```

---

# 🎯 Interview Quick Revision

* CloudWatch = Monitoring service
* Metrics = Numeric data
* Logs = Event records
* Dashboard = Visual monitoring
* Alarm = Threshold trigger
* SNS = Notification service
* Custom Metric = User-defined metric
* CloudTrail = API activity tracking

---

# 📌 Summary

| Service        | Purpose              |
| -------------- | -------------------- |
| CloudWatch     | Monitor resources    |
| Metrics        | Performance data     |
| Logs           | Event records        |
| Alarm          | Trigger action       |
| SNS            | Send notification    |
| Custom Metrics | User-defined metrics |
| CloudTrail     | Audit activity       |

---


