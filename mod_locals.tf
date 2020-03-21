locals {
  # Common tags to be assigned to all resources
  dev = {
    vpc_cidr_block = local.service_name
    subnet_cidr_block   = local.owner
    instance_type = "t2.micro"
    image_id	= "ami-66506c1c"
  }
  prod = {
    vpc_cidr_block = local.service_name
    subnet_cidr_block   = local.owner
    instance_type = "t2.micro"
    image_id	= "ami-66506c1c"
  }
}
