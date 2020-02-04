
data "template_file" "servian-template" {
  template = file("template/conf.tpl")
  vars = {
    DBUSER = var.DBUSER
    DBPASS = var.DBPASS
    DBNAME= var.DBNAME
    DBHOST = aws_db_instance.postgres.address
    S3BUCKET = var.S3BUCKET
  }
}

resource "aws_launch_configuration" "servian-launchconfig" {
  name_prefix     = "servian-launchconfig"
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = "t2.micro"
  key_name        = var.NameOfKey
  security_groups = [aws_security_group.servian-instance.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  user_data = data.template_file.servian-template.rendered
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "servian-autoscaling" {
  name                      = "servian-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  launch_configuration      = aws_launch_configuration.servian-launchconfig.name
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.my-elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}

