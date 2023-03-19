data "aws_ami" "ami-linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_launch_template" "myec2" {
  name_prefix            = "web-"
  instance_type          = var.instance_type
  image_id               = data.aws_ami.ami-linux.id
  vpc_security_group_ids = [var.web_sg]
   user_data              = filebase64("install_apache.sh")
  tags = {
    name = "myec2"
  }
}

resource "aws_autoscaling_group" "web" {
  name                = "web"
  desired_capacity    = 2
  min_size            = 2
  max_size            = 3
  vpc_zone_identifier = tolist(var.public_subnet_1)

  launch_template {
    id      = aws_launch_template.myec2.id
    version = "$Latest"
  }
}















