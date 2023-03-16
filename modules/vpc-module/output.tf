output "vpcID" {
 value= aws_vpc.my_vpc.id
}

output "subnetID" {
 value= aws_subnet.public_subnet.id
}