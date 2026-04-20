output "ec2_public_ip" {
  value = {
    for name, instance in aws_instance.my_ec2_instance :
    name => instance.public_ip
  }
}

output "ec2_public_dns" {
  value = {
    for name, instance in aws_instance.my_ec2_instance :
    name => instance.public_dns
  }
}

output "ec2_private_ip" {
  value = {
    for name, instance in aws_instance.my_ec2_instance :
    name => instance.private_ip
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}