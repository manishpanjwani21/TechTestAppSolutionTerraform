output "instance" {
  value = aws_instance.servian.public_ip
}

output "rds" {
  value = aws_db_instance.postgres.endpoint
}

