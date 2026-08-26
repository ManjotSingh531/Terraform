#RDS Resources
resource "aws_db_subnet_group" "mariadb_subnet" {
    name = "mariadb_subnet"
    description = "Amazon RDS Subnet Group"
    subnet_ids = [aws_subnet.gibs_private_subnet_1.id, aws_subnet.gibs_private_subnet_2.id]
}

#RDS Parameters
resource "aws_db_parameter_group" "mariadb-parameter" {
    name = "mariadb-parameter"
    family = "mariadb11.4"
    description = "MariaDB Parameter group"

    parameter {
      name = "aws_allow_packet"
      value = "16777218"
    }
}

#RDS Instance
resource "aws_db_instance" "gibs_mariadb" {
    allocated_storage    = 20
    db_name              = "gibs"
    engine               = "mariadb"
    engine_version       = "11.4"
    instance_class       = "db.t3.micro"
    username             = "admin"
    password             = "123456"
    parameter_group_name = aws_db_parameter_group.mariadb-parameter.name
    db_subnet_group_name = aws_db_subnet_group.mariadb_subnet.name
    multi_az = "false"
    vpc_security_group_ids = [aws_security_group.allow-mariadb.id]
    storage_type = "gp3"
    backup_retention_period = 30
    availability_zone = aws_subnet.gibs_private_subnet_1.availability_zone
    skip_final_snapshot  = true

    tags = {
      name = "gibs_mariadb"
    }
}

output "rds" {
    value = aws_db_instance.gibs_mariadb.endpoint
}