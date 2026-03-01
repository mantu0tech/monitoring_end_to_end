ELK Stack Installation on AWS (Ubuntu EC2)

This guide explains how to install and configure the ELK Stack (Elasticsearch, Logstash, Kibana) with Filebeat on an Ubuntu EC2 instance in AWS.

📌 ELK Architecture
Server → Data Collection → Logstash → Elasticsearch → Kibana

Server → Generates logs

Filebeat → Collects logs

Logstash → Processes logs

Elasticsearch → Stores logs

Kibana → Visualizes logs

1️⃣ Launch EC2 Instance

AMI: Ubuntu (22.04 recommended)

Instance Type: t2.medium

Storage: 30 GB

Open Security Group Ports:

22 (SSH)

80 (HTTP)

9200 (Elasticsearch - optional internal)

5601 (Kibana - internal only)

Connect to instance:

ssh -i your-key.pem ubuntu@<Public-IP>
2️⃣ Update System
sudo apt update
sudo apt upgrade -y
3️⃣ Install Java (Required for ELK)
sudo apt install openjdk-21-jdk -y

Verify:

java --version
4️⃣ Install Nginx
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
5️⃣ Add Elastic Repository

Add GPG key:

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

Add repository:

echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-9.x.list

Update and install:

sudo apt-get update
sudo apt-get install elasticsearch kibana logstash filebeat -y
6️⃣ Start and Enable Services
sudo systemctl start elasticsearch kibana logstash filebeat
sudo systemctl enable elasticsearch kibana logstash filebeat
sudo systemctl status elasticsearch kibana logstash filebeat
7️⃣ Configure Elasticsearch

Edit config:

sudo vi /etc/elasticsearch/elasticsearch.yml

Update:

cluster.name: my-application
node.name: node-1
network.host: localhost
http.port: 9200

Restart:

sudo systemctl restart elasticsearch

Test:

curl http://localhost:9200
8️⃣ Configure Kibana

Edit:

sudo vi /etc/kibana/kibana.yml

Uncomment and update:

server.host: "localhost"
server.port: 5601

Restart:

sudo systemctl restart kibana
9️⃣ Secure Kibana with Nginx (Basic Auth)
Install htpasswd tool
sudo apt install apache2-utils -y
Create user
sudo htpasswd -c /etc/nginx/htpasswd.users kibana

Verify:

sudo cat /etc/nginx/htpasswd.users
Configure Nginx Reverse Proxy

Backup default config:

sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup

Create new config:

sudo vi /etc/nginx/sites-available/default

Add:

server {
    listen 80;
    server_name <YOUR_PUBLIC_IP>;

    auth_basic "Restricted Access";
    auth_basic_user_file /etc/nginx/htpasswd.users;

    location / {
        proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

Restart:

sudo systemctl restart nginx

Now open in browser:

http://<YOUR_PUBLIC_IP>

Login:

Username: kibana

Password: (your created password)

🔐 10️⃣ Enroll Kibana (If Required)

Generate enrollment token:

sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

Paste token in Kibana UI.

Get verification code:

sudo /usr/share/kibana/bin/kibana-verification-code

Enter the code in Kibana.

After a few minutes, Kibana will be ready.

1️⃣1️⃣ Load Sample Data

In Kibana:

Go to Home

Click Try Sample Data

Install Sample Web Logs

Go to Dashboard

Explore logs

Change time frame

Share or export

1️⃣2️⃣ Configure Filebeat (Collect System Logs)

List modules:

sudo filebeat modules list

Enable system module:

sudo filebeat modules enable system

Edit module config:

sudo vi /etc/filebeat/modules.d/system.yml

Under syslog:

enabled: true
var.paths: ["/var/log/syslog*"]

Under auth:

enabled: true
var.paths: ["/var/log/auth.log*"]

Restart:

sudo systemctl restart filebeat

If needed:

sudo systemctl stop filebeat
sudo systemctl start filebeat
1️⃣3️⃣ Verify Data in Kibana

In Kibana:

Go to Stack Management

Click Index Management

Look for filebeat-*

1️⃣4️⃣ Create Index Pattern

Go to Stack Management

Click Index Patterns

Click Create index pattern

Enter:

filebeat*

Select timestamp field

Click Create

1️⃣5️⃣ Create Visualization

Go to Visualize

Click Create

Choose Pie Chart

Select filebeat*

Configure fields

Save visualization

Add to dashboard

1️⃣6️⃣ Load Default Filebeat Dashboards
sudo filebeat setup -e

This installs prebuilt dashboards.

Refresh Kibana → Dashboards → View Filebeat dashboards.

✅ Final Result

You now have:

Elasticsearch running on port 9200

Kibana secured behind Nginx

Filebeat collecting system logs

Custom dashboards created

Prebuilt dashboards installed

🎯 ELK Stack is Successfully Installed on AWS Ubuntu EC2

You can now:

Collect logs from applications

Create visualizations

Build dashboards

Monitor system logs in real-time