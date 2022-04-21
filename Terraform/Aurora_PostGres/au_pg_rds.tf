provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "rds-sub-a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
}

resource "aws_subnet" "rds-sub-b" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "aurora_postgres_subnet_group"
  description = "description"
  subnet_ids  = [
    aws_subnet.rds-sub-a.id,
    aws_subnet.rds-sub-b.id,
  ]
}

resource "aws_security_group" "db-sg" {
    name = "db-sg"
    vpc_id = aws_vpc.my-vpc.id
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # in case we want to allow access from any ip
        security_groups = [aws_security_group.app-sg-group.id]  # in case we want to allow access from any application security group
    }
}


resource "aws_rds_cluster" "postgresql" {
  depends_on = [aws_security_group.db-sg, aws_db_subnet_group.rds_subnet_group]
  cluster_identifier = "aurora-postgres-cluster"
  engine = "aurora-postgresql"
  engine_version = "12.4"
  engine_mode = "provisioned"
  database_name = "aurora_postgres"
  master_username = "admin"
  master_password = "admin123"
  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name
  security_group_names = [aws_security_group.db-sg.name] 
  db_cluster_instance_class = "db.r5.large"
  allocated_storage = "10"
  iam_database_authentication_enabled = true
  kms_key_id = "key-id" # in case we want to encrypt the data
  storage_encrypted = true
  port = 5432

}