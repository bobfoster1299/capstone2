By Rob Foster 17/01/2020

# Introduction
This project does the following:
- Creates network infrastructure in AWS
- Builds a three-node kubernetes cluster on EC2 instances
- Builds a jenkins server on an EC2 instance
- Creates a CI/CD pipeline in jenkins with staging and production branches
- Builds a docker image and pushes it to Docker Hub
- Deploys containers to kubernetes

# Instructions
These are the basic steps for building the environment:
- Run the CloudFormation capstone-infra script to build the AWS network infrastructure
- Run the CloudFormation capstone-k8s-cluster script to build the kubernetes cluster
- SSH into the kubernetes master and run the following to configure the network:
```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```
- Obtain the join command:
```
kubeadm token create --print-join-command
```
- SSH into the two kubernetes worker nodes and run the join command to join them to the cluster
- Run the CloudFormation capstone-jenkins script to the build the jenkins server
- Run the ansible jenkins script against the jenkins server
- Connect to the jenkins server via the browser and complete the install via the GUI
- Install the Blue Ocean plugins and the Kubernetes Continuous Deploy plugins
- In your GitHub repo create a personal access token
- In jenkins add a username/password credential to connect to GitHub:
  - Username: your GitHub account name  
  - Password: the personal access token generated above
  - ID: github_key
- In jenkins add a username/password credential to connect to Docker Hub:
  - Username: your docker username
  - Password: your docker password
  - ID: docker_hub_login
- In jenkins add a 'Kubernetes configuration (kubeconfig)' credential to connect to kubernetes:
  - ID: kubeconfig
  - Enter directly: the contents of ~/.kube/config from the kubernetes master

The configuration is now complete. Every time you push code to git you can go into jenkins and click Build Now to trigger a new build and deploy to kubernetes.

# Files

**cloudformation/create.sh** - create new AWS stack.

**cloudformation/update.sh** - update existing AWS stack.

**cloudformation/delete.sh** - delete AWS stack.

**cloudformation/capstone-infra.yml** - cloudformation script to deploy network infrastructure in AWS.

**capstone-k8s-cluster.yml** - cloudformation script to deploy kubernetes cluster in AWS.

**cloudformation/capstone-jenkins.yml** - cloudformation script to deploy a jenkins server in AWS.

**ansible/jenkins/** - ansible playbook to further configure the jenkins server. Must be executed manually once the node is running.

**Dockerfile** - creates docker image running Apache for hosting website.

**Jenkinsfile** - creates jenkins pipeline for deploying to staging and production.

**capstone-kube.yml** - creates kubernetes deployment and service.

**public-html/*** - HTML files for website.

