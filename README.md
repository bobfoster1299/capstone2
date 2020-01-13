By Rob Foster 13/01/2020

# Files

### create.sh
Create new AWS stack

### update.sh
Update existing AWS stack

### delete.sh
Delete AWS stack

## Infrastructure

### capstone-infra.yml
AWS CloudFormation script to deploy:
- VPC
- Internet gateway
- Internet gateway attachment
- Public subnet
- Public route table
- Default public route
- Public subnet route table association

## Jenkins

### capstone-jenkins.yml
AWS CloudFormation script to deploy:
- EC2 instance with Jenkins installed (installation must be finished off manually via the browser)
- Security group

### ansible/jenkins/*
Ansible playbook to further configure the jenkins node. Must be executed manually once the node is running.

## Kubernetes

### capstone-k8s.yml
AWS CloudFormation script to deploy:
- 1 x EC2 instance - kubernetes master
- 2 x EC2 instance - kubernetes worker nodes (after building you need to login to the nodes and execute the kubenetes join command)
- Security group

## Staging / Production
Currently the apps are deployed directly to the staging/production nodes. They don't run in containers.

### capstone-staging/production.yml 
AWS CloudFormation script to deploy:
- EC2 instance
- Security group

### ansible/webservers/*
Ansible playbook to configure the staging node. Must be executed manually once the node is running.
