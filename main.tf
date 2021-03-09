provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "terraform" {
  ami = "ami-0767046d1677be5a0"
  instance_type = "t2.micro"
  key_name = "vms"
  vpc_security_group_ids = [aws_security_group.terraform.id]
  connection  {
    host= self.public_ip
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/vms.pem")
  }

  provisioner "file" {
   source      = "script.sh"
   destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }

}

resource "aws_security_group" "terraform"{
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
