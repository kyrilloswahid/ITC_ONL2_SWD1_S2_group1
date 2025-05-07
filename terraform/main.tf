terraform {
  backend "s3" {
    bucket = "kyrillos-terraform-state"
    key    = "todo-app/terraform/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "todo_sg" {
  name        = "todo-app-sg"
  description = "Allow SSH, app, and MongoDB access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "todo_server" {
  ami                         = "ami-053b0d53c279acc90" # Ubuntu 22.04 (us-east-1)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.todo_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "todo-server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/kyrillos-ec2-key.pem")
      host        = self.public_ip
    }
  }
}
