resource "aws_security_group" "app-sg" {
    name = "APP_SG"
        vpc_id = aws_vpc.my-vpc.id
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_groups = [aws_security_group.httpd-sg.id]
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

resource "aws_launch_configuration" "app-lc" {
    name_prefix = "app-asg-lc-"
    image_id = "ami-00000000" # replace with valid AMI ID
    instance_type = "t2.micro"
    security_groups = [aws_security_group.app-sg.id]
    user_data = file("app-install.sh")
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "app-asg" {
    name = "app-asg"
    max_size = 4
    min_size = 1
    desired_capacity = 2
    launch_configuration = aws_launch_configuration.app-lc.name
    vpc_zone_identifier = [aws_subnet.app-sub-a.id, aws_subnet.app-sub-b.id]
    health_check_type = "ELB"
    load_balancers = aws_lb.app-alb.id
}

resource "aws_autoscaling_policy" "app-policy-up" {
    name = "app-policy-scale-up"
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = 1
    autoscaling_group_name = aws_autoscaling_group.app-asg.name
    cooldown = 300
}

resource "aws_autoscaling_policy" "app-policy-down" {
    name = "app-policy-scale-down"
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = -1
    autoscaling_group_name = aws_autoscaling_group.app-asg.name
    cooldown = 300
}

resource "aws_cloudwatch_metric_alarm" "app_cpu_alarm_up" {
    alarm_name = "app-cpu-alarm-up"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    statistic = "Average"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = 70.0
    period = 300
    evaluation_periods = 3
    alarm_description = "This metric monitors the CPU utilization of the app-asg"
    dimensions = {
        "AutoScalingGroupName" = aws_autoscaling_group.app-asg.name
    }
    alarm_actions = [aws_autoscaling_policy.app-policy-up.arn]
    unit = "Percent"
}

resource "aws_cloudwatch_metric_alarm" "app_cpu_alarm_down" {
    alarm_name = "app-cpu-alarm-down"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    statistic = "Average"
    comparison_operator = "LessThanOrEqualToThreshold"
    threshold = 30.0
    period = 300
    evaluation_periods = 3
    alarm_description = "This metric monitors the CPU utilization of the app-asg"
    dimensions = {
        "AutoScalingGroupName" = aws_autoscaling_group.app-asg.name
    }
    alarm_actions = [aws_autoscaling_policy.app-policy-down.arn]
    unit = "Percent"
}