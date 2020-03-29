locals {
  # Common tags to be assigned to all resources
  environment = {
    dev = {
      vpc_cidr_block = "10.1.0.0/16"
      subnet_cidr_block   = "10.1.1.0/24"
      instance_type = "i3.large"
      image_id	= "ami-4bf3d731"
      playbook = "postgres-dev.yml"
      max_conns = "20"
    }
    prod = {
      vpc_cidr_block = "10.2.0.0/16"
      subnet_cidr_block   = "10.2.1.0/24"
      instance_type = "i3.xlarge"
      image_id	= "ami-4bf3d731"
      playbook = "postgres-prod.yml"
      max_conns = "30"
    }
}

env = merge(
    local.environment[var.cluster_id]
    )
}
