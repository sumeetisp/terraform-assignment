resource "aws_db_subnet_group" "db_subnet_grp" {
  name       = "main"
  subnet_ids = var.db_subnets
}


resource "aws_db_instance" "cms_db" {
  allocated_storage    =  var.db_storage
  storage_type         = var.db_type
  engine               = var.db_engine
  engine_version       = var.db_version
  instance_class       = var.db_class
  name                 = var.db_name
  username             = "mysqluser"
  password             = "StrongPassword"
  parameter_group_name = "default.mysql5.7"
  allocated_storage     = 50
  max_allocated_storage = 100
  publicly_accessibe = false
  db_subnet_group_name = resource.aws_db_subnet_group.db_subnet_grp.name
}
