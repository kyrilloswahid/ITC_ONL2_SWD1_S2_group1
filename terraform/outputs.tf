output "instance_public_ip" {
  value = module.todo_ec2.instance_public_ip
}

output "instance_public_dns" {
  value = module.todo_ec2.instance_public_dns
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/kyrillos-ec2-key.pem ubuntu@${module.todo_ec2.instance_public_ip}"
}

output "security_group_id" {
  value = module.todo_security_group.sg_id
}

