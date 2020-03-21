resource "aws_instance" "example" {
  ami           = "${var.image_id}"
  instance_type = "${var.instance_type}"
  subnet_id = var.vpc_subnet_id

  user_data    = <<-EOF
                  #!/bin/bash
                  sudo yum -y update
                  sudo yum -y install epel-repo
                  sudo yum -y update
                  yum -y install ansible
                  EOF
}
