<div align="center">
  <h1 style="color: red;">Deploy FlaskApp on EKS using Azure DevOps :globe_with_meridians::hammer_and_wrench:</h1>
</div>

## :star2: Introduction:-
- The primary objective of this project is to establish a robust end-to-end Continuous Integration and Continuous Deployment (CI/CD) pipeline for a web application hosted on a Kubernetes cluster. Leveraging the power of Azure DevOps, this project showcases the seamless automation of software development, testing, and deployment processes.

## :gear: Requirements:-
- :white_check_mark: Github
- :white_check_mark: Terraform
- :white_check_mark: AWS
- :white_check_mark: Docker 
- :white_check_mark: Ansible
- :white_check_mark: Kubernetes
- :white_check_mark: Azure DevOps

## :scroll: Project Structure:-
- Github: GitHub Actions workflow directory containing the CI/CD configuration.
- Terraform: Configurations for provisioning infrastructure on AWS such as VPC, subnets, EC2, EKS, ECR, CloudWatch, SNS and more.
- Ansible: Automating the configuration of EC2 by installing AWS CLI, kubectl and Docker.
- Docker: Building Dockerfiles for Flask-App and MySQL DB.
- Kubernetes: Creating Kubernetes manifests for deploying the Flask app and MySQL DB on the EKS cluster.
- Azure DevOps: Configuring a Release Pipeline to automate the build, push and deployment process.

## :diamond_shape_with_a_dot_inside: Steps to run project:-
1. Clone the Repository:
```
git clone git@github.com:amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps.git
```
2. Open local terminal to add AWS credentials:
```
cd .aws
nano credentials
```
![WhatsApp Image 2023-12-20 at 3 54 48 PM](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/1926b45c-c077-422e-bd83-103b6c6111bd)
