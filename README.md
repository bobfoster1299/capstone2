By Rob Foster 13/01/2020

# Introduction

This project does the following:

- Creates network infrastructure in AWS
- Builds a three-node kubernetes cluster on EC2 instances
- Builds a Jenkins server on an EC2 instance
- Creates a CI/CD pipeline in Jenkins with staging and production branches
- Builds a docker container and deploys it to kubernetes

# Instructions
These are the basic steps for building the environment:

- Run the CloudFormation capstone-infra script to build the AWS network infrastructure
- Run the CloudFormation capstone-k8s-cluster script to build the kubernetes cluster
- SSH into the kubernetes master and run the following to configure the network:
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
- Obtain the join command:
kubeadm token create --print-join-command
- SSH into the two kubernetes worker nodes and run the join command to join them to the cluster
- Run the CloudFormation capstone-jenkins script to the build the Jenkins server
- Run the ansible jenkins script against the Jenkins server
- Connect to the Jenkins server via the browser and complete the install via the GUI
- Install the Blue Ocean plugins and the Kubernetes Continuous Deploy plugins
- In your GitHub repo create a personal access token
- In Jenkins add a username/password credential to connect to GitHub:
-- Username: your GitHub account name  
-- Password: the personal access token generated above
-- ID: github_key
- In Jenkins add a username/password credential to connect to Docker Hub:
-- Username: your docker username
-- Password: your docker password
-- ID: docker_hub_login
- In Jenkins add a Kubernetes configuration (kubeconfig) credential to connect to kubernetes:
-- ID: kubeconfig
-- Enter directly: the contents of ~/.kube/config from the kubernetes master

The configuration is now complete. Every time you push code to git you can go into jenkins and click Build Now to trigger a new build and deploy to kubernetes.




# Files

### cloudformation/create.sh
Create new AWS stack

### cloudformation/update.sh
Update existing AWS stack

### cloudformation/delete.sh
Delete AWS stack

### cloudformation/capstone-infra.yml
AWS CloudFormation script to deploy:
- VPC
- Internet gateway
- Internet gateway attachment
- Public subnet
- Public route table
- Default public route
- Public subnet route table association

### capstone-k8s-cluster.yml
AWS CloudFormation script to deploy:
- 1 x EC2 instance - kubernetes master
- 2 x EC2 instance - kubernetes worker nodes
- Security group

### cloudformation/capstone-jenkins.yml
AWS CloudFormation script to deploy:
- EC2 instance with Jenkins installed (installation must be finished off manually via the browser)
- Security group

### ansible/jenkins/*
Ansible playbook to further configure the jenkins node. Must be executed manually once the node is running.

### Dockerfile
Creates docker container running Apache for hosting website

### Jenkinsfile
Creates Jenkins pipeline for deploying to staging and production

### capstone-kube.yml
Creates kubernetes deployment and service

### public-html/*
HTML files for website

