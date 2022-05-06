resource "aws_internet_gateway" "adamant-codes-igw" {
    vpc_id = "${aws_vpc.adamant-codes-vpc.id}"
    tags = {
        Name = "adamant-codes-igw"
    }
}

resource "aws_route_table" "adamant-codes-route-table" {
    vpc_id = "${aws_vpc.adamant-codes-vpc.id}"

    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.adamant-codes-igw.id}" 
    }
    
    tags = {
        Name = "adamant-codes-route-table"
    }
}

resource "aws_route_table_association" "adamant-codes-route-table-public-subnet-1"{
    subnet_id = "${aws_subnet.adamant-codes-subnet-public-1.id}"
    route_table_id = "${aws_route_table.adamant-codes-route-table.id}"
}

resource "aws_security_group" "adamant-codes-sg" {
    vpc_id = "${aws_vpc.adamant-codes-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }
    //If you do not add this rule, you can not reach the NGIX  
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "adamant-codes-sg"
    }
}