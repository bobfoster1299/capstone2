By Rob Foster 

Updated 08/08/2020

# Introduction
This is my capstone project for the Cloud DevOps Engineer nanodegree program from [Udacity](https://udacity.com).

It does the following:
- Creates network infrastructure in AWS.
- Builds a three-node kubernetes cluster on EC2 instances.
- Builds a jenkins server on an EC2 instance.
- Creates a CI/CD pipeline in jenkins with staging and production branches.
- Builds a docker image containing apache website and pushes it to Docker Hub.
- Deploys the docker containers to kubernetes using rolling deployment.

# Instructions
These are the basic steps for building the environment:
- Run the cloudformation capstone-infra script to build the AWS network infrastructure:
```
./create.sh capstone-infra capstone-infra.yml capstone-infra.json
```
- Run the cloudformation capstone-k8s-cluster script to build the kubernetes cluster:
```
./create.sh capstone-k8s-cluster capstone-k8s-cluster.yml capstone-k8s-cluster.json
```
- SSH into the kubernetes master and run the following to configure the network:
```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```
- Obtain the join command:
```
kubeadm token create --print-join-command
```
- SSH into the two kubernetes worker nodes and run the join command to join them to the cluster.
- Run the cloudformation capstone-jenkins script to build the jenkins server:
```
./create.sh capstone-jenkins capstone-jenkins.yml capstone-jenkins.json
```
- Run the ansible jenkins script against the jenkins server:
```
ansible-playbook -i inv -u centos --private-key ~/yourkey.pem jenkins.yml
```
- Connect to the jenkins server via the browser and complete the install via the GUI.
- Install the Blue Ocean plugins and the Kubernetes Continuous Deploy plugins.
- In your GitHub repo create a personal access token.
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

The configuration is now complete. Every time you push code to git you can go into jenkins and click Build Now to trigger a new build and deploy to kubernetes. You can deploy to either staging or production, depending on which branch you commit to in GitHub. 

# Files

[cloudformation/create.sh](cloudformation/create.sh) - create new AWS stack.

[cloudformation/update.sh](cloudformation/update.sh) - update existing AWS stack.

[cloudformation/delete.sh](cloudformation/delete.sh) - delete AWS stack.

[cloudformation/capstone-infra.yml](cloudformation/capstone-infra.yml) - cloudformation script to deploy network infrastructure in AWS.

[cloudformation/capstone-k8s-cluster.yml](cloudformation/capstone-k8s-cluster.yml) - cloudformation script to deploy kubernetes cluster in AWS.

[cloudformation/capstone-jenkins.yml](cloudformation/capstone-jenkins.yml) - cloudformation script to deploy a jenkins server in AWS.

[ansible/jenkins/*](ansible/jenkins) - ansible playbook to further configure the jenkins server. Must be executed manually once the node is running.

[Dockerfile](Dockerfile) - creates docker image running apache for hosting website.

[Jenkinsfile](Jenkinsfile) - creates jenkins pipeline for deploying to staging and production.

[capstone-kube.yml](capstone-kube.yml) - creates kubernetes deployment and service.

[public-html/*](public-html) - HTML files for website.

