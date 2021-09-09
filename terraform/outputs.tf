#
# Output
#

# AMI ID

output "image_id" {
  value = data.aws_ami.ubuntu.id
}

# lw server details

# output "lw_server_name" {
#   value = [aws_instance.lw-reesy.tags.*.Name]
# }

output "lw_server_id" {
  value = [aws_instance.lw-reesy.*.id]
}

# output "lw_server_ami" {
#   value = aws_instance.lw-reesy.ami
# }

# output "lw_serverinstance_type" {
#   value = aws_instance.lw-reesy.instance_type
# }

output "lw_server_public_ip" {
  value = [aws_instance.lw-reesy.*.public_ip]
}


# networking details

output "vpc_id" {
  value = aws_vpc.default.id
}

output "subnet_public_id" {
  value = aws_subnet.public.id
}

output "subnet_private_id" {
  value = aws_subnet.private.id
}

output "security_group_lw_id" {
  value = aws_security_group.lw.id
}

output "security_group_ssh_id" {
  value = aws_security_group.ssh.id
}

output "route_internet_access_id" {
  value = aws_route.internet_access.route_table_id
}