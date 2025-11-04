resource "aws_security_group" "project_sg" {

      name        = "project-sg"
      vpc_id      = aws_vpc.project-vpc.id


 dynamic "ingress" {
    for_each = [22, 80, 8080, 3306]  # List of ports
    content {
      description = "Allow port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

