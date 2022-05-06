resource "aws_vpc" "adamant-codes-vpc" {
    cidr_block = "192.168.0.0/16"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    enable_classiclink = "false"
    instance_tenancy = "default"    
    
    tags = {
        Name = "adamant-codes-vpc"
    }
}

resource "aws_subnet" "adamant-codes-subnet-public-1" {
    vpc_id = "${aws_vpc.adamant-codes-vpc.id}"
    cidr_block = "192.168.100.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "ap-southeast-1a"
    tags = {
        Name = "adamant-codes-subnet-public-1"
    }
}