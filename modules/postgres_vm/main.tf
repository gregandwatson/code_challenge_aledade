resource "aws_instance" "main" {
  ami           = var.image_id
  instance_type = var.instance_type
  subnet_id = var.vpc_subnet_id
  user_data    = <<-EOF
                  #!/bin/bash
                  sudo yum -y update
                  sudo yum -y install python
                  EOF
  provisioner "local-exec" {
    command = "ansible-playbook -u ec2-user -i '${aws_instance.main.public_ip},' --private-key ${var.ssh_key_private} ${var.postgres_playbook}"
  }
}
