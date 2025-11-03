resource "aws_instance" "project-node-1" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = "t2.micro"
    key_name = "N.verginia-key"
    subnet_id = aws_subnet.project-vpc-public-1.id
    vpc_security_group_ids = ["${aws_security_group.project_sg.id}"]
    associate_public_ip_address = true
    tags = {
        Name = "project-dev-1"
        Environment = "Dev"
    }
}
resource "aws_instance" "project-node-2" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = "t2.micro"
    key_name = "N.verginia-key"
    subnet_id = aws_subnet.project-vpc-public-2.id
    vpc_security_group_ids = [aws_security_group.project_sg.id]
    associate_public_ip_address = true
    tags = {
        Name = "project-qa-1"
        Environment = "QA"
    }
}
resource "aws_instance" "project-automation-master" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = "t2.micro"
    key_name = "N.verginia-key"
    subnet_id = aws_subnet.project-vpc-public-3.id
    vpc_security_group_ids = [aws_security_group.project_sg.id]
    associate_public_ip_address = true

    tags = {
        Name = "project-automation-master"
        
    }
}
