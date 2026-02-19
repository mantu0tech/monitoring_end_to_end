📊 Grafana Installation & Dashboard Setup Guide

This guide explains how to:

Install Grafana on Debian/Ubuntu
Access Grafana Web UI
Understand Grafana menu options
Add InfluxDB as a data source
Create dashboards
Add a Geomap (World Map) visualization

🚀 Install Grafana (Debian / Ubuntu)

Official documentation:
https://grafana.com/docs/grafana/latest/setup-grafana/installation/debian/

1️⃣ Update System Packages
sudo apt update

Install required dependencies:

sudo apt-get install -y apt-transport-https wget gnupg

2️⃣ Add Grafana GPG Key
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

3️⃣ Add Grafana Repository
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

4️⃣ Install Grafana

Update package list:
sudo apt-get update


Install Grafana OSS:
sudo apt-get install grafana

5️⃣ Start Grafana Service
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
sudo systemctl status grafana-server

🌐 Access Grafana

Grafana runs on port 3000.

Make sure port 3000 is open in your server/instance firewall.

Open your browser and enter:

http://<your-server-ip>:3000


Example:

http://192.168.1.10:3000

🔐 Default Login Credentials
Username: admin
Password: admin


You will be asked to change the password after first login.

🧭 Grafana Main Menu Overview

Here’s what each section means:

Home – Main starting page.

Bookmarks – Saved quick links.

Starred – Favorite dashboards.

Dashboards – Create and manage dashboards.

Explore – Run real-time queries.

Drilldown – View detailed data from panels.

Alerting – Configure alerts and notifications.

Connections – Manage data sources.

Administration – User and system management.

📊 Create a Dashboard

Go to Dashboards

Click Add New Dashboard

Click Add → Visualization

Select your Data Source (Example: InfluxDB)

Run your query

Click Apply

Save the dashboard

🌍 Add World Map (Geomap) in Grafana
4

Grafana already includes the Geomap visualization plugin.

Steps to Add Geomap:

Go to Dashboard

Click Add → Visualization

In visualization search bar, type Geomap

Select Geomap

Configure your data source

Click Apply

You will now see the world map visualization.

