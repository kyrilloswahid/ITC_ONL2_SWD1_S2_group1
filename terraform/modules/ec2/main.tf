resource "aws_instance" "todo_server" {
  ami                         = "ami-053b0d53c279acc90" # Ubuntu 22.04 (us-east-1)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true

  tags = {
    Name = "todo-server"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for SSH to be ready...'",
      "while ! nc -z localhost 22; do sleep 5; done",
      "echo 'SSH is ready. Running updates.'",
      "sudo apt update",
      "echo 'Remote exec completed'"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/kyrillos-ec2-key.pem")
      host        = self.public_ip
      timeout     = "10m"   # Extended timeout (10 minutes)
      agent        = false
      insecure     = true   # Disable host key checking (for new servers)
    }
  }
}

