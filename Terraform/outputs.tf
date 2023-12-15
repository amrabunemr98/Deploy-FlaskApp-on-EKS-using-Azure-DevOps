output "Public-ip-instance" {
  value = aws_instance.ec2.public_ip
}

output "ecr-url" {
    value = aws_ecr_repository.task_ecr.repository_url
}

# output "ebs-url" {
#     value = aws_ebs_volume.my_ebs_volume.id
# }

