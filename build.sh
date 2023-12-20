#!/bin/bash

# Run Terraform
Run_Terraform() {
    echo "Running Terraform..."
    cd /home/abunemr/Bootcamp/Task/Terraform
    terraform init
    terraform apply -auto-approve
    instance_ip=$(terraform output Public-ip-instance)
    cd -
    echo "Terraform Completed"
}
# Update inventory
Update_Inventory() {
    echo "It's Updating Ansible inventory"
    inventory_file="/home/abunemr/Bootcamp/Task/ansible/inventory.txt"

    # Replace the IP address of the target host in the inventory file
    echo -e "Task ansible_host=${instance_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/abunemr/task.pem" > "${inventory_file}"

    echo "Ansible inventory updated"
}
# Function to run Ansible
Run_Ansible() {
    echo "Ansible is running"
    cd /home/abunemr/Bootcamp/Task/ansible/
    export ANSIBLE_HOST_KEY_CHECKING=False
    ansible-playbook -i inventory.txt playbook.yml
    cd -
    echo "Ansible completed"
}



echo "It will start to run all scripts "
Run_Terraform
echo "Terraform Fininshed SuccessFully"
Update_Inventory
echo "Inventory Updated SuccessFully"
sleep 5
Run_Ansible
echo "Ansible Finished SuccessFully"
echo "All Scripts Finished."
