// Create Security Group
resource "aws_security_group" "my_sg" {
 name        = "my_sg"
 vpc_id      = var.vpc_id

ingress {
   description = "SSH access"
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
}
ingress {
   description = "http access"
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
    Name = "sg-ec2"
  }
}