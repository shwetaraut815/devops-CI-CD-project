resource "aws_db_instance" "db" {
  allocated_storage    = "10"
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = local.db_creds.username
  password             = local.db_creds.password
  #prameter_group_name = "test.mysql8.0"
  skip_final_snapshot  = false

}