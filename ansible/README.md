# Ansible Playbook 

## Purpose
- This Ansible playbook automates the setup of a target environment for managing resources on AWS and Kubernetes. It includes tasks such as installing necessary packages, configuring the AWS CLI, setting up credentials, installing kubectl, and interacting with an Amazon EKS cluster.

## Playbook Structure
1.  Load Variables
- The playbook starts by loading variables from an external file [variables.yml](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/blob/main/ansible/variables.yml) to ensure a clean separation of configuration.
2. Install Required Packages
- Installs necessary packages (unzip, ca-certificates, curl, apt-transport-https) on the target hosts.
3. Install AWS CLI
  - Checks if the AWS CLI is installed; if not, installs it. The AWS CLI installation includes downloading the AWS CLI v2, extracting it, and configuring its installation path.
4. AWS CLI Configuration
- Creates the .aws directory in the home directory, sets up an AWS credentials file with access keys, and sets appropriate permissions.
5. Install kubectl
- Downloads and installs kubectl binary for interacting with Kubernetes clusters.
6. Configure kubectl for the User
- Updates the user's .bashrc file to include the directory containing kubectl in the PATH.
7. Set Ownership and Permissions for .aws Directory
- Ensures proper ownership and permissions for the .aws directory.
8. Update kubeconfig
- Updates the kubeconfig file to include the configuration of the specified EKS cluster.
9. Update APT Package Manager Cache
- Updates the APT package manager cache on the target hosts.
10. Install Docker
- Installs the Docker package on the target hosts.
11. Configure Docker Socket Ownership and Permissions
- Adjusts ownership and permissions for the Docker socket (/var/run/docker.sock).

## Usage
1. Ensure that Ansible is installed on the machine where you intend to run this playbook.
2. Create a file named variables.yml with the required variables.
3. Run the playbook using the following command:
```
ansible-playbook -i inventory.ini playbook.yml
```
