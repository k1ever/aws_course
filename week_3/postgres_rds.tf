resource "aws_db_instance" "postgres_rds" {
  identifier             = "postgres-rds-terraform"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "13.7"
  username               = "postgres"
  password               = "testpwd1"
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  publicly_accessible = true
  skip_final_snapshot = true
}