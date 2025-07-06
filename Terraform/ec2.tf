resource "aws_instance" "app_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io git
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -a -G docker ubuntu

              # Pull the Docker image from Docker Hub (replace 'fuhchu' with your Docker Hub username)
              docker pull fuhchu/my-dev-env-apache:latest
              docker run -d \
                --name my-app-container \
                -p 80:80 \
                -e DB_HOST=${aws_db_instance.main.address} \
                -e DB_PORT=${aws_db_instance.main.port} \
                -e DB_NAME=${var.db_name} \
                -e DB_USER=${var.db_username} \
                -e DB_PASSWORD=${var.db_password} \
                fuhchu/my-dev-env-apache:latest

              EOF

  tags = {
    Name = "DockerAppServer"
  }

  depends_on = [
    aws_db_instance.main
  ]
}