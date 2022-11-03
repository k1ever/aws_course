resource "aws_db_instance" "postgres_rds" {
  identifier             = var.rds_identifier
  instance_class         = "db.t3.micro"
  allocated_storage      = var.rds_allocated_storage
  engine                 = "postgres"
  engine_version         = "13.7"
  username               = var.rds_default_username
  password               = var.rds_default_user_password
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  publicly_accessible    = true
  skip_final_snapshot    = true
}