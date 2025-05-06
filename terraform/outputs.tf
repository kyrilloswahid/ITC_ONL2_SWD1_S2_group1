output "instance_public_ip" {
  value       = aws_instance.todo_server.public_ip
}

output "instance_public_dns" {
  value       = aws_instance.todo_server.public_dns
}

output "ssh_command" {
  value       = "ssh -i ~/.ssh/kyrillos-ec2-key.pem ubuntu@${aws_instance.todo_server.public_ip}"
}
