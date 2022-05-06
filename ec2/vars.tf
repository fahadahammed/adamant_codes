variable "AWS_REGION" {    
    default = "ap-southeast-1"
}

variable "AWS_PROFILE" {
    default = "fahad"
}

variable "PRIVATE_KEY_PATH" {
  default = "adamant-codes-key-pair"
}

variable "PUBLIC_KEY_PATH" {
  default = "adamant-codes-key-pair.pub"
}

variable "EC2_USER" {
  default = "ubuntu"
}

variable "AMI" {    
    default = {
        ap-southeast-1 = "ami-055d15d9cfddf7bd3"
    }
}