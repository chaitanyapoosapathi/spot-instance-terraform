provider "aws" {  
  region = "ca-central-1"
}

resource "aws_spot_instance_request" "cheap_worker" {
  ami           = data.aws_ami.example.id
  spot_price    = "0.02"
  instance_type = "t2.medium"
  root_block_device {
    volume_size = "25"
  }
  key_name = "ec2"
  security_groups = ["launch-wizard-4"]
  tags = {
    Name = "CheapWorker"
  }
}

data "aws_ami" "example" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["minikube-*"]
  }
}

output "public-ip" {
  value = aws_spot_instance_request.cheap_worker.public_ip
}
