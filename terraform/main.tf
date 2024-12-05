#
# Data
#

# This retrieves the latest AMI ID for Ubuntu 22.04.

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  common_tags = {
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }
}

resource "random_id" "random" {
  byte_length = 4
}

#
# instances
#

resource "aws_instance" "lw-kenny" {
  count                  = var.node_counter
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.linux_node_instance_type
  key_name               = var.aws_key_pair_name
  availability_zone      = "${var.aws_region}${var.aws_availability_zone}"
  vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.lw.id]
  subnet_id              = aws_subnet.public.id
  iam_instance_profile   = aws_iam_instance_profile.lw_instance_profile.name

  root_block_device {
    delete_on_termination = true
    volume_size           = 100
    volume_type           = "gp2"
  }

  tags = {
    Name          = "lw-kenny-ec2-${count.index}"
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }

  connection {
    user        = "ubuntu"
    private_key = file(var.aws_key_pair_file)
    host        = self.public_ip
  }

  provisioner "file" {
    content     = templatefile("${path.module}/templates/linux_node_user_data.sh.tpl", { lw_token = var.lw_token })
    destination = "/tmp/linux_node_user_data.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "bash /tmp/linux_node_user_data.sh"
    ]
  }

}

