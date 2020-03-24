locals {
  # Common tags to be assigned to all resources
  environment = {
    dev = {
      vpc_cidr_block = "10.1.0.0/16"
      subnet_cidr_block   = "10.1.1.0/24"
      instance_type = "t2.micro"
      image_id	= "ami-66506c1c"
      playbook = "postgres-dev.yml"
    }
    prod = {
      vpc_cidr_block = "10.2.0.0/16"
      subnet_cidr_block   = "10.2.1.0/24"
      instance_type = "t2.micro"
      image_id	= "ami-66506c1c"
      playbook = "postgres-prod.yml"
    }
}

env = merge(
    local.environment[var.cluster_id]
    )
}
