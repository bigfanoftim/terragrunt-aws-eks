output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_ids" {
  value = { for key, subnet in aws_subnet.this : key => subnet.id }
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "cidr_block" {
  value = aws_vpc.this.cidr_block
}