data "template_file" "servian-template-updatedb" {
  template = file("templateupdatedb/conf.tpl")
  vars = {
    DBUSER = var.DBUSER
    DBPASS = var.DBPASS
    DBNAME= var.DBNAME
    DBHOST = aws_db_instance.postgres.address
    S3BUCKET = var.S3BUCKET
  }
}

resource "aws_instance" "servian" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.servian-instance.id]
  
  # Script to do build and push to S3
  user_data = data.template_file.servian-template-updatedb.rendered

  # adding iam role for access to s3
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  
  # the public SSH key
  key_name = var.NameOfKey
  tags = {
    key                 = "Name"
    value               = "ec2 dbupdate"
  }
}

