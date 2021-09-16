To get all details

root@ip-172-31-7-171:~# kubectl get all

To check pods 

$ kubectl get pods –all-namespaces

To check API Version

kubectl api-versions

To list out Services on a particular namespace

kubectl get svc -n <namspace_name>

Note : if we don’t specify any namespace, it will list from default namespace.

To list of all pods from all namespaces

kubectl get pods –all-namespaces

To create a new pod

Ex : to create httpd

# kubectl create deployment httpd –image=httpd

Ex: to create nginx

# kubectl create deployment nginx –image=nginx

To get token to join worker nodes

# kubeadm token create –print-join-command

To create Logging namespace

# kubectl create namespace logging

To have elastic.yaml file

# kubectl create -f kubernetes/elastic.yaml -n logging

To make changes to deployment and Apply

# Kubectl apply <namespace> logging

To check more details ( in wide ) of the get pods output

# kubectl get pods –all-namespaces -o wide

To check Kubernetes logs

# journalctl -u kubelet

To get deployment object

# kubectl get deploy

To check details of Pods

Ex: to check the pods with name app.

# kubectl get pods |grep app

To find Replication set

# kubectl get rs

To find service for a particular deployment

# kubectl get svc -n kubernetes-dashboard

To get the services created

# kubectl get svc -n <service_name>

(or)

# kubectl get svc

To Edit the deployment

# kubectl edit deployment <deployment_name>

To check the history  deployment

# kubectl rollout history deployment <Deployment_name>

To find helm Version

# helm version

To find Configuration view

# kubectl config view

To get Service Accounts list

# Kubectl get serviceaccounts

To create new Service Account run below as one command

# kubectl apply -f – <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: build-robot
EOF

To find all the labels

# kubectl get pods –show-labels

To find details of a Service

# kubectl describe svc <service_name>

To create ClusterIP

# kubectl expose <object> <object_name> –name <name> –port <any_port> –target-port <object_port> –type ClusterIP

To create LoadBalencer

# kubectl expose <object> <object_name> –name <name> –port <any_port> –target-port <object_port> –type LoadBalencer

To create NodePort

# kubectl expose <object> <object_name> –name <name> –port <any_port> –target-port <object_port> –type NodePort

To find man page of any kubernetes object 

Below is an Example

  $ kubectl explain service

  $ kubectl explain Pod

To untaint all including master

# kubectl taint nodes –all node-role.kubernetes.io/master

To continuously access application in the replica set

while true; do curl 10.111.27.27;sleep 1;echo “”;done

To extract yaml file out of a pod

# kubectl get pod <pod_name> -o yaml

# kubectl get pod <pod_name> -o yaml

To check service account

# kubectl -n <namespace> get sa

To get the cluster roles

# kubectl get cluesterroles

To check the configuration file using command

# kubectl config view –minify

Create adhoc pod

# kubectl create deployment nginx –image=nginx

To run all commands in a particular namespace with out specifying namespace

# kubectl config set-context –current –namespace=devops-tools

To get the list of Storage classes

# kubectl get storageclassses.storage.k8s.io

**Kubernetes Delete commands**

To delete pods

# kubectl delete pods <pod1> <pod2> <pod3> ….

To delete Deployment (this will delete all the resources (pods, services etc) created through this deployment

# kubectl delete deployment <deployment_name>

To delete service

# kubectl delete service <service_name>

Note : A statefulset pod can not be by deleting only the pod directly, instead we have to delete the Statefulset.

**Kubernetes Troubleshooting commands**

To find what pods are on what nodes

# kubectl get pods –all-namespaces -o wide

(or)

# kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName –all-namespaces

To display Daemon Set

# kubectl get ds

To get logs of a pod

# kubectl logs <Pod_Name>

Ex :

# kubectl logs nginx-6799fc88d8-qs42c –tail=20

To check apiserver is running or has crashed.

# docker ps | grep kube-apiserver

To Rollout

Example :

root@osboxes:/home/osboxes/sreek8# kubectl rollout status deploy kubeserve

deployment “kubeserve” successfully rolled out

root@osboxes:/home/osboxes/sreek8# kubectl rollout history deploy kubeserve

deployment.extensions/kubeserve 

REVISION  CHANGE-CAUSE

1         <none>

To check restart policy

# kubectl get pods sreedeploy-7dc4f58d88-25f5f -o yaml |grep -i restart

To check what is running in cluster

Ex :

# kubectl cluster-info

Kubernetes control plane is running at https://0.0.0.0:53875

CoreDNS is running at https://0.0.0.0:53875/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

Metrics-server is running at https://0.0.0.0:53875/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

To check kubelet config file

# ps – |grep kubelet

To check the kubernetes configuration

# kubectl config view

To check the Kubernetes dump logs

# kubectl cluster-info dump

To check external IP’s of nodes in k8s

# kubectl get nodes -o wide | awk {‘print $1″ ” $2 ” ” $6’} | column -t

(or)

# kubectl get nodes -o wide

Verify that you can access the load balancer externally

curl -silent *****.eu-west-1.elb.amazonaws.com:80 | grep title

**Security commands**

To getsecrets

# kubectl get secrets

**AWS EKS Commands**

To update kube configuration to aws eks

# aws eks –region us-east-2 update-kubeconfig –name <cluster_name>