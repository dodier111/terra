resource "aws_db_instance" "education" {
  identifier             = "education"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "8.0.35"
  username               = "admin"
  password               = var.db_password
  publicly_accessible    = true
  skip_final_snapshot    = true
}
