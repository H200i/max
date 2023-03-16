// Create EC2 instances
resource "aws_instance" "my_ec2" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  key_name = "keyu"
  user_data = "${data.template_file.userdata.rendered}"
  security_groups = [var.sg_id]
  subnet_id= var.sbnet_id
  tags = {
    Name = "my-ec2"
  }
}

// Create Userdata
data "template_file" "userdata" {
 template = "${file("modules/ec2-module/apache_config.sh")}"
 vars = {
   namevalue = 10
}
}