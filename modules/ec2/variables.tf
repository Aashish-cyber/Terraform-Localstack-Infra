variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "availability_zone" {
  description = "Availability zone for instance"
  type        = string
  default     = "us-east-1a"
}

variable "instance_name" {
  description = "Name tag for instance"
  type        = string
  default     = "demo-instance"
}
