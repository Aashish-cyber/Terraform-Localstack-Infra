output "ec2_host_id" {
  description = "EC2 host ID"
  value       = aws_ec2_host.demo.id
}

output "instance_type" {
  description = "Instance type"
  value       = aws_ec2_host.demo.instance_type
}
