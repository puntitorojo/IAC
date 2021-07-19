variable "security_group_name" {
  type        = string
  description = "Name for the security group"
  default     = "Allow_SSH_From_Home"
}

variable "aws_profile" {
  type        = string
  description = "The name of the AWS profile as set in the shared credentials file."
  default     = "default"
}

variable "aws_region_id" {
  type        = string
  description = "The id of the region in AWS"
  default     = "us-east-1"
}

variable "aws_shared_credentials_file" {
  type        = string
  description = "path to shared credential's file"
  default     = "~/.aws/credentials"
}

variable "aws_vpc_id" {
  type        = string
  description = "VPC-ID"
  default     = "vpc-0b92127e4ec17bdc0"
}

variable "aws_subnet_id_test_pub" {
  description = "Subnet ID"
  default     = ["subnet-048de71976717e5e3", "subnet-068259d264422cfe8"]
}

variable "aws_subnet_id_test_priv" {
  description = "Subnet ID"
  default     = ["subnet-017793fdbf2e6fbe4", "subnet-019b981bdfdc963e0"]
}

variable "ingress_ssh_cidr_block" {
  type        = string
  description = "CIDR block for incoming communication: SSH"
  default     = "186.138.114.166/32"
}

variable "ingress_icmp_cidr_block" {
  type        = string
  description = "CIDR block for incoming communication: ICMP"
  default     = "186.138.114.166/32"
}

variable "ingress_http_cidr_block" {
  type        = string
  description = "allow external communication to www service"
  default     = "186.138.114.166/32"
}

variable "egress_cidr_block_all" {
  type        = string
  description = "CIDR block for outgoing communication ALL traffic"
  default     = "0.0.0.0/0"
}

variable "number_of_instances" {
  type        = string
  description = "numbers of instances"
  default     = "2"
}

variable "pki_name" {
  type        = string
  description = "The name of the key file"
  default     = "tf-day3"
}

variable "ami_id" {
  type        = string
  description = "ami id"
  default     = "ami-0beafb294c86717a8"
}

variable "the_instances" {
  description = "list of names"
  type = list(string)
  default = [
    "instancia-1",
    "instancia-2",
    "instancia-3",
    "instancia-4",
    "instancia-5",
  ]
}
