<div align="center">
  <h1 style="color: red;">Deploy FlaskApp on EKS using Azure DevOps :globe_with_meridians::hammer_and_wrench:</h1>
</div>
![Presentation 3](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/45fe5638-20fb-463c-ab0a-cb401e702146)

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
```
```
nano credentials
```
![WhatsApp Image 2023-12-20 at 3 54 48 PM](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/1926b45c-c077-422e-bd83-103b6c6111bd)

3. Run [Bash Script](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/blob/main/build.sh) :
```
sudo chmod +x build.sh
```
```
./build.sh
```
4. Launch Bastion-Host Instance to Configure AWS Credentials and Set Up EKS Configuration and Access :
```
sudo chown -R ubuntu:ubuntu /home/ubuntu/.aws
```
```
aws configure
```
```
chmod 600 /home/ubuntu/.aws/credentials
```
```
aws eks --region us-east-1 update-kubeconfig --name task-EKS-Cluster
```
![WhatsApp Image 2023-12-20 at 4 09 55 PM](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/00b5afd7-fa73-4c61-b4c3-5d61d9a39796)

5. Role-Based Access Control (RBAC) Authorization for Amazon EKS
- This project utilizes Role-Based Access Control (RBAC) for secure and granular access to the Amazon Elastic Kubernetes Service (EKS) cluster. RBAC ensures that users and services have the appropriate permissions to perform specific actions within the Kubernetes cluster. Additionally, Azure DevOps is employed for streamlined CI/CD pipelines, enabling seamless deployment workflows.
- Create file.yml on Bastion-Host EC2 and copy this content of this file [RBAC EKS](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/blob/main/Access-EKS.yml):
```
nano file.yml
``` 
```
kubectl apply -f file.yml
```
- Use output and add it in service conneections in Azure DevOps:
```
kubectl get secret deploy-robot-secret -n default -o json
```
 ![WhatsApp Image 2023-12-20 at 4 07 15 PM](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/9d43629f-6720-4a28-85cc-73b33098bdf9)
 ![Screenshot from 2023-12-20 16-32-49](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/4094f0a4-2aa8-433f-b420-42233e2dea69)
 ![Screenshot from 2023-12-20 10-25-18](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/9499d2ba-7b60-44a9-a159-de2d91f70f76)

 6. Adding AWS Credentials in Service Connection in Azure Devops to access services of AWS:
![Screenshot from 2023-12-20 10-25-35](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/e2d54cb7-c21a-4c6f-9a85-bd3d26db698a)

7. Adding GitHub Personal Access Token to Azure DevOps Service Connection:
![WhatsApp Image 2023-12-20 at 4 40 15 PM](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/15722c5d-2758-4b05-81de-9858c7db1c74)
![Screenshot from 2023-12-20 10-25-59](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/b218d708-eac2-4a9e-955c-27c1a8e09fd2)

8. Creating a Pipeline in Azure DevOps using a Release Pipeline:
- Create stage for build docker image for Flask-App & MySQL DB and push images to ECR
![Screenshot from 2023-12-20 16-49-25](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/fe6c4a43-a9e8-455f-971b-b4742ab4da01)
![Screenshot from 2023-12-20 16-49-40](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/b426e972-5815-44db-aa2e-d015cad05172)

- Create stage for Run manifest files of K8S
![Screenshot from 2023-12-20 16-53-09](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/a3ba55fa-9b69-46fa-bc64-15ebba8178b5)

- Create release and choose: Deploy Multiple for 2 stages
![Screenshot from 2023-12-20 10-29-29](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/b69170bd-370f-4895-af8e-192bd4f46a15)
![Screenshot from 2023-12-20 09-52-43](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/97698c00-712d-4c18-9201-32065d66b7fe)
![Screenshot from 2023-12-20 11-03-35](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/d2b83039-60e3-4a3d-9bfc-d0b7e4451b70)

9. Check Kubernetes Cluster Status:
- Run the following commands to check the status of different Kubernetes components
```
kubectl get nods
```
```
kubectl get pods
```
```
kubectl get pv
```
```
kubectl get pvc
```
```
kubectl get svc
```
```
kubectl get ingress
```
```
kubectl get secret
```
```
kubectl get configmap
```
![Screenshot from 2023-12-20 10-31-37](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/37f40315-1659-4f08-a130-0e9b4b134259)

10. Access Flask Application:
- After the release pipeline completes, find the DNS of LoadBalancer and search of DNS in your browser
![Screenshot from 2023-12-20 10-35-04](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/86f09575-21a6-4ff4-a955-caf3330deba7)
------------------------------------------------------------------------
![Screenshot from 2023-12-20 10-06-20](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/389e2fd5-f8fa-404c-91a7-4706d5215d02)
----------------------------------------------------
![Screenshot from 2023-12-20 10-06-50](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/f3241c5d-1b28-466c-8969-694d7f87a358)
--------------------------------------------------
![Screenshot from 2023-12-20 10-06-59](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/408fbbcc-23ad-4f26-824a-0424a2268b7a)

11. Logs are collected from Amazon EC2 instances and Log streams are created to organize and categorize logs for easy analysis, and Metrics are gathered from AWS EC2 instances such as CPU utilization are monitored to track the health and performance of resources through CloudWatch Logs & Metrics:
![Screenshot from 2023-12-20 10-32-38](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/1a2efae2-0bc6-4eb2-9ce1-b0ce2919094c)
![Screenshot from 2023-12-20 10-23-11](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/491d50e2-4497-453c-a945-d9cadc512497)
![Screenshot from 2023-12-20 10-23-23](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/07b721a4-a265-4692-9e92-423c77ae17d6)

13. An email subscription is added to the SNS topic to receive alerts:
![Screenshot from 2023-12-20 10-23-52](https://github.com/amrabunemr98/Deploy-FlaskApp-on-EKS-using-Azure-DevOps/assets/128842547/f91f056c-aec5-49ec-a82e-74b9b514d1a4)

> [!IMPORTANT]
> Ensure that you have the necessary permissions and security measures in place for accessing AWS resources and sensitive data.
> Make sure the bash script is appropriately structured and contain the necessary commands and configurations.

## :rocket: Conclusion:-
- Through a series of carefully orchestrated steps, I've built a fully automated CI/CD pipeline for a flask application, leveraging an array of powerful tools and technologies. Throughout this project, I've gained practical experience in provisioning infrastructure with Terraform, configuring services using Ansible, containerizing applications with Docker, orchestrating deployments on Kubernetes, and automating workflows with azure devops pipeline. By seamlessly integrating these tools, so i have demonstrated a mastery of essential DevOps practices that empower efficient and reliable software delivery.

## :open_book: Additional Resources and References:-
- Throughout of this project, I found the following resources to be immensely helpful:
1. Terraform Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
2. Ansible Documentation: https://docs.ansible.com/ansible/latest/index.html
3. Kubernetes Documentation: https://kubernetes.io/docs/home/
4. Kubernetes RBAC Documentation: https://kubernetes.io/docs/reference/access-authn-authz/rbac/

> [!NOTE]
> Remember that these steps provide a high-level overview of the process. You'll need to fill in the specific commands and configurations for each step based on your project's requirements and your environment. Test each step thoroughly and make adjustments as needed to ensure a smooth and successful deployment process.





