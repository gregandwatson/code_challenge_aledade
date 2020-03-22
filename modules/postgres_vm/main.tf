resource "aws_instance" "example" {
  ami           = "${var.image_id}"
  instance_type = "${var.instance_type}"
  subnet_id = var.vpc_subnet_id
}
