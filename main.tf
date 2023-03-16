
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIARL3KQGVIJHHY5QKE"
  secret_key = "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"
}


module "vpc-module" {
  source = ".//modules/vpc-module"
  vpc_cidr= var.vpc_cidr
}

module "sg-module" {
  source = ".//modules/sg-module"
  vpc_id = module.vpc-module.vpcID
}

module "ec2-module" {
  source = ".//modules/ec2-module"
  sg_id = module.sg-module.sgID
  sbnet_id = module.vpc-module.subnetID
}




/*


// Create Private RT
resource "aws_route_table" "Private-Subnet-RT" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "Route Table for NAT Gateway"
  }
}

// Associate private subnets to private RT
resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  count =       length(local.sub) 
  subnet_id      = aws_subnet.my_subnet[count.index].id
  route_table_id = aws_route_table.Private-Subnet-RT.id
}


// Create EIP for NAT Gateway
resource "aws_eip" "ng_eip" {
  vpc = true
}

// Create NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.ng_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "gw NAT"
  }
}

// Create Private Subnets
resource "aws_subnet" "my_subnet" {
  count         = length(local.sub) 
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = local.sub[count.index]
  availability_zone  = local.az[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-$(local.sub[count.index])"
  }
}





//----------------------------ALB Code------------------------------------//

// Create Application Load balancer 
resource "aws_lb" "my_lb" {
  name               = "mylb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_sg.id]
  subnets            = [aws_subnet.public_subnet[0].id,aws_subnet.public_subnet[1].id]

}

// Create ALB Listener
resource "aws_lb_listener" "my_lis" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}

// Create Target Group
resource "aws_lb_target_group" "my_tg" {
  name     = "mytg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}

// Attach EC2 instances to the target group
resource "aws_lb_target_group_attachment" "attach-app1" {
  count=2
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id        = aws_instance.my_ec2[count.index].id
  port             = 80
}

//------------------------------Route 53 Code---------------------------------//

// Create route 53 Hosted zone
resource "aws_route53_zone" "my_zone" {
  name     = "glowfy.co.uk"
}

// Create route 53 record
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.my_zone.id
  name    = "www.glowfy.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_lb.my_lb.dns_name]
}

*/


