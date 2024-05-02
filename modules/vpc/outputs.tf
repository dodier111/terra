output "vpc_name" {
    value = var.vpc_name
}
  
output "vpc_id" {
    value = aws_vpc.main.id
}

output "subnet1" {
    value = aws_subnet.subnet1.id
}

output "internet_gateway" {
    value = aws_internet_gateway.main
}