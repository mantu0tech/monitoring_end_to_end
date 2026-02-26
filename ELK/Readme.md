let's see how to install ELK on AWS and use it 

elk architecture 

server >data collection >> logstash >> Elastic search >> kibana 

select ubuntu ec2 >> t2 medium > 30 gb storage 
launch it 

sudo apt update 

sudo apt install openjdk-21-jdk >> for ELK java is IMP 

sudo apt update 
sudo apt install nginx 

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-9.x.list

sudo apt-get update && sudo apt-get install elasticsearch kibana logstash filebeat 

it will downlaod evertgin 

verify nwow 

java --version 
sudo systemctl status nginx 

 sudo systemctl start  elasticsearch kibana logstash filebeat

  sudo systemctl status  elasticsearch kibana logstash filebeat

   sudo systemctl enable elasticsearch kibana logstash filebeat

   now lets see how to use it!!

   sudo vi "/etc/elasticsearch/elasticsearch.yml"
change all these thign in the file 
   
   cluster.name: my-application
   node.name: node-1
   network.host: localhost
   http.port: 9200

now save and exit 

sudo systemctl restart elasticsearch.service
reatet it 

it is working in port no 9200

sudo vi /etc/kibana/kibana.yml

server.host: "localhost"
server.port: 5601

uncomment these 2 line nad save it 
sudo systemctl restart kibana

we are going to add the username and password in nginx so we can access the kibana 

sudo apt install apache2-utils 

sudo htpasswd -c /etc/nginx/htpasswd.users kibana 
htpasword hash the password 
/etc/nginx/htpasswd.users username ans password will store 

it will ask you to enter the password 

 sudo cat /etc/nginx/htpasswd.users
 you  can see your password is stored in hash way 

 username kibana
 password kibana 

 sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/backup

 sudo mv /etc/nginx/sites-available/default 

 server {
    listen 80;

    server_name <Instance-Private IP>;

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

add these in your 