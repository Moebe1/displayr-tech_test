resource "aws_security_group" "sg" {
    name = "displayr-Mo-TechTest"
    description = "Security Group for Hello World Webserver"
    vpc_id = aws_vpc.hello_world_vpc.id
    
    # ingress {
    #     description = "SSH into EC2"
    #     from_port = 22
    #     to_port = 22
    #     protocol = "tcp"
    #     cidr_blocks = [ "0.0.0.0/0" ]
    #     ipv6_cidr_blocks = [ "::/0" ]
    # }
    
    ingress {
        description = "Inbound HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = [ "::/0" ]
    }

    ingress {
        description = "ICMP"
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = [ "::/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
    }
}
