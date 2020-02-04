resource "aws_instance" "servianbuild" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id
  # Script to do build and push to S3
  user_data       = "${file("BuildandPush.sh")}"
  # the security group
  vpc_security_group_ids = [aws_security_group.servianbuild-instance.id]

  # adding iam role for access to s3
  iam_instance_profile = aws_iam_instance_profile.ec2_build_profile.name
  # the public SSH key
  key_name = var.NameOfKey
}

