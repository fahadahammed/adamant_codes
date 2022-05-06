resource "aws_instance" "adamant-app-server" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t3a.micro"
    
    # VPC
    subnet_id = "${aws_subnet.adamant-codes-subnet-public-1.id}"
    
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.adamant-codes-sg.id}"]
    
    # the Public SSH key
    key_name = "${aws_key_pair.adamant-codes-key-pair.id}"

    root_block_device {
          volume_size = 50
          delete_on_termination = true
    }
    
    # nginx installation
    provisioner "file" {
        source = "nginx.sh"
        destination = "/tmp/nginx.sh"
    }
    provisioner "remote-exec" {
        inline = [
             "chmod +x /tmp/nginx.sh",
             "sudo /tmp/nginx.sh"
        ]
    }
    connection {
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
        host = self.public_ip
    }

  tags = {
    Name = "Flugel"
    Owner = "InfraTeam"
  }

}
// Sends your public key to the instance
resource "aws_key_pair" "adamant-codes-key-pair" {
    key_name = "adamant-codes-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}

output "instance-private-ip" {
  value = aws_instance.adamant-app-server.private_ip
}

output "instance-public-ip" {
  value = aws_instance.adamant-app-server.public_ip
}

output "instance-tags" {
    value = aws_instance.adamant-app-server.tags
}