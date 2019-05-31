provider "aws"
 {
  access_key = "AKIAIJDYBFP3PAKRPGOQ"
  secret_key = "BSTrP9iTx+1QoVyK/Vv6/H0pIiLNR+qM9lOVyctf"
  region     = "ap-south-1"
 }resource "aws_security_group" "default"
 {
  name = "terraform-example-instance"
  vpc_id = "vpc-066c476e"  
  
  ingress
 {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  egress
    {
     from_port = 0
     to_port = 0
     protocol = "-1"
     cidr_blocks = ["0.0.0.0/0"]
    }
tags = {
    Name = "allow"
  }

} 

resource "aws_instance" "terraform"
 {
  ami           = "ami-e41b618b"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags
  {
    Name = "terraform-example"
  } 

}
