variable "cluster_id" {
  default = "prod"
}

variable "vpc_cidr_block" {
  default = ""
}

variable "subnet_cidr_block" {
  default = ""
}

variable "image_id" {
  default = ""
}

variable "instance_type" {
  default = ""
}

variable "postgres_playbook" {
  default = ""
}

variable "ssh_key_private" {
  default = ""
}

variable "public_key" {
  default = ""
}
