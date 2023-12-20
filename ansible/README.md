# Ansible Playbook 

## Purpose
- This Ansible playbook automates the setup of a target environment for managing resources on AWS and Kubernetes. It includes tasks such as installing necessary packages, configuring the AWS CLI, setting up credentials, installing kubectl, and interacting with an Amazon EKS cluster.

## Playbook Structure
1.  Load Variables
- The playbook starts by loading variables from an external file [variables.yml](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/blob/main/ansible/variables.yml) to ensure a clean separation of configuration.
