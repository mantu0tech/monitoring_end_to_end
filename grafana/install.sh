sudo apt update 

sudo apt-get install -y apt-transport-https wget gnupg -y 


sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# Updates the list of available packages
sudo apt-get update -y

# Installs the latest OSS release:
sudo apt-get install grafana -y 

sudo systemctl start  grafana-server

sudo systemctl enable  grafana-server

sudo systemctl status   grafana-server