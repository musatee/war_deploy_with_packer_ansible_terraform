variable "aws_access_key" {
  sensitive = true
}
variable "aws_secret_key" {
  sensitive = true
}

source "amazon-ebs" "custom_ami" {
  access_key      = var.aws_access_key
  secret_key      = var.aws_secret_key
  ssh_timeout     = "60s"
  region          = "ap-southeast-1"
  source_ami      = "ami-0753e0e42b20e96e3"
  ssh_username    = "ec2-user"
  ami_name        = "inbuilt-war"
  instance_type   = "t2.micro"
  #skip_create_ami = false

}

build {
  sources = [
    "source.amazon-ebs.custom_ami"
  ]
  provisioner "ansible" {
    playbook_file = "./ansible/env_setup_playbook.yaml"
  }
}