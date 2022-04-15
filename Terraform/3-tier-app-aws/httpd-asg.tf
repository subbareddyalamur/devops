resource "aws_security_group" "httpd-sg" {
    name = "HTTPD-SG"
    vpc_id = aws_vpc.my-vpc.id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # should be specific cidr range or an ip
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_launch_configuration" "httpd-lc" {
    name_prefix = "httpd-asg-lc-"
    image_id = "ami-00000000" # replace with valid AMI ID
    instance_type = "t2.micro"
    security_groups = [aws_security_group.httpd-sg.id]
    associate_public_ip_address = true
    user_data = file("httpd-install.sh")
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "httpd-asg" {
    name = "httpd-asg"
    max_size = 4
    min_size = 1
    desired_capacity = 2
    launch_configuration = aws_launch_configuration.httpd-lc.name
    vpc_zone_identifier = [aws_subnet.httpd-sub-a.id, aws_subnet.httpd-sub-b.id]
    health_check_type = "ELB"
    load_balancers = aws_lb.httpd-alb.id
}

resource "aws_autoscaling_policy" "httpd-policy-up" {
    name = "httpd-policy-scale-up"
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = 1
    autoscaling_group_name = aws_autoscaling_group.httpd-asg.name
    cooldown = 300
}

resource "aws_autoscaling_policy" "httpd-policy-down" {
    name = "httpd-policy-scale-down"
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = -1
    autoscaling_group_name = aws_autoscaling_group.httpd-asg.name
    cooldown = 300
}

resource "aws_cloudwatch_metric_alarm" "httpd_cpu_alarm_up" {
    alarm_name = "httpd-cpu-alarm-up"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    statistic = "Average"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = 70.0
    period = 300
    evaluation_periods = 3
    alarm_description = "This metric monitors the CPU utilization of the httpd-asg"
    dimensions = {
        "AutoScalingGroupName" = aws_autoscaling_group.httpd-asg.name
    }
    alarm_actions = [aws_autoscaling_policy.httpd-policy-up.arn]
    unit = "Percent"
}

resource "aws_cloudwatch_metric_alarm" "httpd_cpu_alarm_down" {
    alarm_name = "httpd-cpu-alarm-down"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    statistic = "Average"
    comparison_operator = "LessThanOrEqualToThreshold"
    threshold = 30.0
    period = 300
    evaluation_periods = 3
    alarm_description = "This metric monitors the CPU utilization of the httpd-asg"
    dimensions = {
        "AutoScalingGroupName" = aws_autoscaling_group.httpd-asg.name
    }
    alarm_actions = [aws_autoscaling_policy.httpd-policy-down.arn]
    unit = "Percent"
}