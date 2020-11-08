resource "aws_spot_instance_request" "cheap_worker" {
  ami           = "ami-0dbd6ff6270bd154d"
  spot_price    = "0.02"
  instance_type = "t2.medium"
  root_block_device {
    volume_size = "25"
  }
  key_name = "ec2"
  user_data = file("script.sh")
  security_groups = ["launch-wizard-4"]

  tags = {
    Name = "CheapWorker"
  }
}

output "public ipadress" {
  value = aws_spot_instance_request.cheap_worker.public_ip
}
