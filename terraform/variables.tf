variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "public_key_path" {
  description = "Path to your public SSH key"
  default     = "~/.ssh/id_rsa.pub"
}
