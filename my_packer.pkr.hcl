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
  region          = "us-east-1"
  source_ami      = "ami-0aa7d40eeae50c9a9"
  ssh_username    = "ec2-user"
  ami_name        = "pkrbuilt-tomcat4"
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
