#Auto Scaling Launch Configuration
resource "aws_launch_configuration" "gibs-launchconfig" {
    name_prefix = "gibs-launchconfig"
    image_id = lookup(var.AMI, var.AWS_REGION)
    instance_type = "t3.micro"
    key_name = aws_key_pair.gibs_key.key_name
}

#Generate Key
resource "aws_key_pair" "gibs_key" {
    key_name = "gibs_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Auto Scaling Group
resource "aws_autoscaling_group" "gibs-autoscaling" {
    name = "gibs-autoscaling"
    vpc_zone_identifier = ["ap-south-1b", "ap-south-1a"]
    launch_configuration = aws_launch_configuration.gibs-launchconfig.name
    min_size = 1
    max_size = 2
    health_check_grace_period = 200
    health_check_type = "EC2"
    force_delete = true

    tag {
        key = "Name"
        value = "gibs custom ec2 instance"
        propagate_at_launch = true
    }
}

#Auto Scaling Configuration Plicy - Scale Alarm
resource "aws_autoscaling_policy" "gibs-cpu-policy" {
    name = "gibs-cpu-policy"
    autoscaling_group_name = aws_autoscaling_group.gibs-autoscaling.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = "1"
    cooldown = "200"
    policy_type = "SingleScaling"
}

#Auto Scaling Claud-Watch Monitoring
resource "aws_cloudwatch_metric_alarm" "gibs-cpu-alarm" {
    alarm_name = "gibs-cpu-alarm"
    alarm_description = "Alarm Once CPU User Increase"
    comparison_operator = "GreaterThanOrEqualToThreshhold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWSEC2"
    period = "120"
    statistic = "Average"
    threshold = "30"

    dimensions = {
        "AutoScalingGroupName" = aws_autoscaling_group.gibs-autoscaling.name
    }

    actions_enabled = true
    alarm_actions = [aws_autoscaling_policy.gibs-cpu-policy.arn]
}

#Auto Descaling Configuration Plicy - Scale Alarm
resource "aws_autoscaling_policy" "gibs-cpu-policy-scaledown" {
    name = "gibs-cpu-policy-scaledown"
    autoscaling_group_name = aws_autoscaling_group.gibs-autoscaling.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = "-1"
    cooldown = "200"
    policy_type = "SingleScaling"
}

#Auto Descaling Claud-Watch Monitoring
resource "aws_cloudwatch_metric_alarm" "gibs-cpu-alarm-scaledown" {
    alarm_name = "gibs-cpu-alarm-scaledown"
    alarm_description = "Alarm Once CPU User decrease"
    comparison_operator = "LessThanOrEqualToThreshhold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWSEC2"
    period = "120"
    statistic = "Average"
    threshold = "10"

    dimensions = {
        "AutoScalingGroupName" = aws_autoscaling_group.gibs-autoscaling.name
    }

    actions_enabled = true
    alarm_actions = [aws_autoscaling_policy.gibs-cpu-policy-scaledown.arn]
}