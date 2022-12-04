output "VPC_ID" {
    value = aws_vpc.hello_world_vpc.id  
}

output "public_subnet_id" {
    value= aws_subnet.public_subnet.id
}

output "EC2_Instance_IP" {
    value = aws_instance.hello-world.public_ip 
}

output "hello_world_link" {
    value = aws_instance.hello-world.public_dns
}

output "ec2_instance_type" {
    value = aws_instance.hello-world.instance_type
}

output "ec2_instance_id" {
    value = aws_instance.hello-world.id 
}

output "site_url" {
    value = ["http://${chomp(aws_instance.hello-world.public_dns)}/index.html"]
}
