resource "aws_instance" "jenkinsServer" {
  instance_type = var.instance_type
  ami = var.ami_id
  security_groups = [ aws_security_group.openAll.name ]
  key_name = "linux"
  tags = {
    Name = "JenkinsServer"
  }
  provisioner "file" {
    source = "/home/ec2-user/jenkinsServer/install_jenkins.sh"
    destination = "./install_jenkins.sh" 
  }
  
    provisioner "remote-exec" {
    inline = [
      "chmod +x ./install_jenkins.sh",
      "./install_jenkins.sh"
     ]
  }

  connection {
    type ="ssh"
    host = self.public_ip
    user = "ec2-user"
    private_key = file("/home/ec2-user/jenkinsServer/linux.pem")
    timeout = "4m"
  }
 # provisioner "remote-exec" {
 #   inline = [ 
 #     "chmod +x ./install_jenkins.sh",
 #     "./install_jenkins.sh"
 #    ]
 # }  
}


resource "aws_security_group" "openAll" {
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    
  } 
  egress {
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = [ "0.0.0.0/0" ]
    
  }
}

