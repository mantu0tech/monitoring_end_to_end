in these project we are going to deploy and monitor kubernetes application using grafana and prometheus 


create a ubuntu instance with t2 medium with 20 gb storage 

what is observability 
it is a combination of monitoring adn logging and tracing and alerting 

montoring metrics 
logging logs 
tracing >
alearting >>email notification 
visualized >> dashboard 

what all folder is important 
kind-cluster >>commands.mds
k8s-specifications


refer these repo 
https://github.com/LondheShubham153/k8s-kind-voting-app.git for the project 
clone it and 

as it is kubernetes application then we need to install docker as well 

its is a kind cluster 
KIND(its is kubernetes in docker )

add docker to the group 
 sudo usermod -aG docker ubuntu && newgrp docker

git clone the repo 

now go inside the repo and go to kind-cluster folder 

here you can see the 2 file install kind and kubectl 

now run both the file 
and check the version 

 sudo bash install_kubectl.sh



kubectl version 

sudo bash install_kind.sh

kind --version 

run these file to create a cluster 
kind create cluster --config=config.yml --name=my-cluster

argocd is the simple tool that thake the code(minifiest file ) from github and deploy into your cluster 

 now we create  argo cd 

clear 

kubeclt get nodes 
 here you can refer the commands.md in kind-cluster folder 

our application is runnign on port 31002 

go inside the k8s-specification 

and type kubeclt apply -f . 

and type 
kubectl get app 
to get everthing 

now your application is running 
make sure you application is runing for long time 

now the application is running 

now we need prometheus menifest file and to run these we need HElm 
helm is a package manager for kubernetes to install manage and delete  prometheus , argocd and more 

now to install the helm 
\
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3


chmod 700 get_helm.sh

./get_helm.sh

helm --version

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update


helm install kind-prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --set prometheus.service.nodePort=30000 --set prometheus.service.type=NodePort --set grafana.service.nodePort=31000 --set grafana.service.type=NodePort --set alertmanager.service.nodePort=32000 --set alertmanager.service.type=NodePort --set prometheus-node-exporter.service.nodePort=32001 --set prometheus-node-exporter.service.type=NodePort


kubectl get svc -n monitoring
kubectl get namespace


add all the port number in yoru slides 


