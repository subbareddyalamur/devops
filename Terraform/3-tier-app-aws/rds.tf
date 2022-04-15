resource "aws_db_subnet_group" "default" {
    name        = "db-subnet-group"
    description = "Default db subnet group"
    subnet_ids  = [
        aws_subnet.db-sub-a.id,
        aws_subnet.db-sub-b.id,
    ]
}

resource "aws_security_group" "db-sg" {
    name = "db-sg"
    vpc_id = aws_vpc.my-vpc.id
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.app-sg.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_db_instance" "app-db" {
    identifier = "app-db"
    db_subnet_group_name = aws_db_subnet_group.default.name
    allocated_storage = 10
    engine = "mysql"
    engine_version = "5.6.27"
    instance_class = "db.t2.micro"
    db_name = "app-db"
    password = "password"
    username = "username"
    security_group_names = [aws_security_group.db-sg.name]
    skip_final_snapshot = true
}