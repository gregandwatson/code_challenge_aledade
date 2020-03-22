module "${var.env_id}_postgres_instance" {
  source = "modules/postgres_vm"
  instance_type = local."${var.env_id}".instance_type
  image_id	= local."${var.env_id}".image_id
  user_data    = <<-EOF
                  #!/bin/bash
                  sudo yum -y update
                  sudo yum -y install python
                  EOF
  provisioner "local-exec" {
    command = "ansible-playbook -u fedora -i '${self.public_ip},' --private-key ${var.ssh_key_private} postgres.yml"
  }
}

module "${var.env_id}_vpc" {
  source = "modules/vpc"
  vpc_cidr_block = local."${var.env_id}".vpc_cidr_block
  subnet_cidr_block = local."${var.env_id}".subnet_cidr_block
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "${aws_vpc.greg-ohio-test.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["74.83.20.195/32"]
  }
}

resource "aws_key_pair" "veronika" {
  key_name   = "veronika-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCoTaAVCxUwaMu9Ot3UszKW4jrLalPZ/6EP6JstS9pWwTWduJHvTj0yCIYqPl/xAchgvYAv1693qn+GzQlPRgK4GDwMZe6NMcSmFCKJetxytH2ozeX48sr1YshCmkXtPGGbwYw/B9amBbZZXBkuuFFvDYGDw9n+blQnRXxtNaLU2AvdQ7OGtFweyFdZUwG14eZjc5KHUd+A7paxE6RWqkx6hU2kh9tccF+VY5aLZz5OGTPwVpOqS1Vx6bWZrzOjIkIvzLNr//iOAkJYYYmjwB9zMu6Gc/a5tR7B4VuxCX3YfljDyQ/QcFTYWxQ1hCNbcKy2LDR0/PDXKxTZQ81+fp+z ggreenlee@veronika"
}
