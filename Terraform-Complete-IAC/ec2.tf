# Key pair for login

resource "aws_key_pair" "my_key" {
  key_name   = "key-for-swiggy"
  public_key = file("key-for-swiggy.pub")
  tags = {
    Environment = var.env
  }
}

# vpc & security group

resource "aws_security_group" "my_security_group" {
    name = "${var.env}-automated-security-group"
    description = "This will add a TF generated security group to the default VPC"
    vpc_id = module.vpc.vpc_id

    # ingress rules
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH access from anywhere"   
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP access from anywhere"
    }

    ingress {
        from_port = 9000
        to_port = 9000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow access to SonarQube on port 9000"
    }

    ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow access to port 8080 from anywhere"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }

    tags = {
      Name = "${var.env}-automated-security-group"
      Environment = var.env
    }

}

# ec2 instance

resource "aws_instance" "my_ec2_instance" {
    for_each = tomap({
      Practise-EC2-Instance = var.ec2_instance_type
    })
    depends_on = [ aws_security_group.my_security_group, aws_key_pair.my_key ]

    key_name = aws_key_pair.my_key.key_name
    subnet_id = module.vpc.public_subnets[0]
    vpc_security_group_ids = [aws_security_group.my_security_group.id]  
    instance_type = each.value
    ami = var.ec2_ami_id
    associate_public_ip_address = true
    user_data = file("install_docker.sh")

    root_block_device {
      volume_size = var.env == "prd" ? 20 : var.ec2_default_root_storage_size
      volume_type = "gp2"
    }

    tags = {
      Name = each.key
      Environment = var.env
    }
    
}