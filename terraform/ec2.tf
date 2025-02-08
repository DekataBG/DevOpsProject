provider "aws" {
    region = "eu-central-1" #Frankfurt
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
    ami                         = data.aws_ami.ubuntu.id
    instance_type               = "t2.micro"
    security_groups             = [aws_security_group.allow_web_traffic.name]
    associate_public_ip_address = true
    key_name                    = aws_key_pair.my_key.key_name
}

resource "aws_security_group" "allow_web_traffic" {
    name        = "allow_web_traffic"
    description = "Allow inbound web traffic"

    ingress {
        description = "TLS from anywhere"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH - to test whether the setup works"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "my_key" {
    key_name   = "my-key"
    public_key = file("~/.ssh/id_ed25519.pub")
}

output web {
    value = aws_instance.web.*.public_dns
}