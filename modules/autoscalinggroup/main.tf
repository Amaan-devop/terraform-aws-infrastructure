# resource "aws_placement_group" "smart_psg" {
#   name     = join("-", [var.app_name, "psg"])
#   strategy = "cluster"
# }

resource "aws_launch_template" "smart_launch_template" {
  name_prefix   = join("-", [var.app_name, "template"])
  image_id      = "ami-0e17b4db59f6aafcc"
  instance_type = "t3.micro"
}

resource "aws_autoscaling_group" "bar" {
  name                      = join("-", [var.app_name, "asg"])
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
#   placement_group           = aws_placement_group.smart_psg.id
  launch_template {
    id      = aws_launch_template.smart_launch_template.id
    version = "$Latest"
  }
  #   launch_configuration      = aws_launch_configuration.foobar.name
  vpc_zone_identifier = var.subnets

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

  initial_lifecycle_hook {
    name                 = join("-", [var.app_name, "hook"])
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

    # role_arn = "arn:aws:iam::123456789012:role/S3Access"
  }

  tag {
    key                 = "createby-asg"
    value               = var.app_name
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

}
