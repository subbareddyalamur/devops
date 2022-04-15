resource "aws_security_group" "httpd-alb-sg" {
    name = "HTTPD-ALB-SG"
    vpc_id = aws_vpc.my-vpc.id
    ingress {
        from_port = 80
        to_port = 80
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

resource "aws_lb" "httpd-alb" {
    name = "httpd-alb"
    internal = false
    load_balancer_type = "application"
    enable_cross_zone_load_balancing = true
    security_groups = aws_security_group.httpd-alb-sg.id
    subnets = [aws_subnet.httpd-sub-a.id, aws_subnet.httpd-sub-b.id]
}

resource "aws_lb_listener" "httpd-alb-lstr" {
    load_balancer_arn = aws_lb.httpd-alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
        target_group_arn = aws_lb_target_group.httpd-alb-tg.arn
        type = "forward"
    }
}

resource "aws_lb_target_group" "httpd-alb-tg" {
    name = "httpd-alb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.my-vpc.id
    load_balancing_algorithm_type = "least_outstanding_requests"
    health_check {
      protocol = "HTTP"
      interval = 2
      healthy_threshold = 2
      unhealthy_threshold = 2
    }
    depends_on = [aws_lb.httpd-alb]
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_attachment" "httpd-alb-att" {
    autoscaling_group_name = aws_autoscaling_group.httpd-asg.name
    lb_target_group_arn = aws_lb_target_group.httpd-alb-tg.arn
}