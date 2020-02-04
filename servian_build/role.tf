resource "aws_iam_role" "ec2_build_role" {
  name = "ec2_build_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "ec2-value"
  }
}

resource "aws_iam_instance_profile" "ec2_build_profile" {
  name = "ec2_build_profile"
  role = aws_iam_role.ec2_build_role.name
  }

resource "aws_iam_role_policy" "ec2_build_policy" {
  name = "ec2_build_policy"
  role = aws_iam_role.ec2_build_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}