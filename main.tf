
provider "aws" {
    region = var.aws_region
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

resource "aws_vpc" "hello_world_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.hello_world_vpc.id
  
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.hello_world_vpc.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true
    availability_zone = var.azs
}

resource "aws_route_table" "igw_route" {
    vpc_id = aws_vpc.hello_world_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  
}

resource "aws_route_table_association" "igw_route_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.igw_route.id  
}

resource "aws_instance" "hello-world" {
    
    ami = "ami-055166f8a8041fbf1" #ubuntu 20.04 LTS
    instance_type = var.instance_type
    #key_name = var.instance_keypair
    subnet_id = aws_subnet.public_subnet.id
    security_groups = [aws_security_group.sg.id]

    user_data = <<-EOF
    #!/bin/bash
    echo "Installing APACHE2 Webserver..."
    sudo apt update -y
    sudo apt install apache2 -y
    echo "Webserver installed"
    echo "<!DOCTYPE html> <html> <head> <title>Hello World!</title> </head> <body> <h1>Hello Displayr!</h1> <h2>Thank you for the opportunity to interview for this role.</h2> </body> </html>" > index.html
    sudo cp index.html /var/www/html/index.html
    EOF
    # user_data_replace_on_change = true 

    tags = {
      "Name" = "displayr-Mo-TechTest"
    }
}

# resource "null_resource" "health_check" {
#     provisioner "local-exec" {
#         command = "/bin/bash healthcheck.sh"
#     }
# }