resource "aws_ec2_host" "demo" {
  instance_type     = var.instance_type
  availability_zone = var.availability_zone

  tags = {
    Name = var.instance_name
  }
}
