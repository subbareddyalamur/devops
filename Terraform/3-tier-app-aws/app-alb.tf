resource "aws_security_group" "app-alb-sg" {
    name = "APP-ALB-SG"
    vpc_id = aws_vpc.my-vpc.id
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_lb" "app-alb" {
    name = "app-alb"
    internal = false
    load_balancer_type = "application"
    enable_cross_zone_load_balancing = true
    security_groups = aws_security_group.app-alb-sg.id
    subnets = [aws_subnet.app-sub-a.id, aws_subnet.app-sub-b.id]
}

resource "aws_lb_listener" "app-alb-lstr" {
    load_balancer_arn = aws_lb.app-alb.arn
    port = 8080
    protocol = "HTTP"
    default_action {
        target_group_arn = aws_lb_target_group.app-alb-tg.arn
        type = "forward"
    }
}

resource "aws_lb_target_group" "app-alb-tg" {
    name = "app-alb-tg"
    port = 8080
    protocol = "HTTP"
    vpc_id = aws_vpc.my-vpc.id
    load_balancing_algorithm_type = "least_outstanding_requests"
    health_check {
      protocol = "HTTP"
      interval = 2
      healthy_threshold = 2
      unhealthy_threshold = 2
    }
    depends_on = [aws_lb.app-alb]
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_attachment" "app-alb-att" {
    autoscaling_group_name = aws_autoscaling_group.app-asg.name
    lb_target_group_arn = aws_lb_target_group.app-alb-tg.arn
}