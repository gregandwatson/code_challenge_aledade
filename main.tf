module "postgres_instance" {
  source = "./modules/postgres_vm"
  instance_type = local.env.instance_type
  image_id	= local.env.image_id
  postgres_playbook = local.env.playbook
  keypair_name = aws_key_pair.veronika.key_name
  ssh_key_private = "~/.ssh.id_rsa"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block = local.env.vpc_cidr_block
  subnet_cidr_block = local.env.subnet_cidr_block
}

resource "aws_key_pair" "veronika" {
  key_name   = "veronika-key"
  public_key = var.public_key
}

data "template_file" "hosts" {
  template = file("hosts.tpl")
  vars = {
    host_ip = module.postgres_instance.postgres_public_ip
    env = ${var.cluster_id}
    max_conns = local.env.max_conns
  }
}

resource "local_file" "hosts" {
    content     = data.template_file.hosts.rendered
    filename = "hosts"
}
