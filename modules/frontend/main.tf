provider "aws" {
	profile = "default"
	region = var.cms_region
}

resource "aws_launch_template" "cms_instance_template" {
  name_prefix   = "cms"
  image_id      = lookup(var.cms_images, var.cms_region)
  instance_type = var.cms_instance_size
}

resource "aws_autoscaling_group" "cms_asg" {
  name = "cms_scaling_group"
  availability_zones = var.cms_zones
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = "${aws_launch_template.cmd_instance_template.id}"
    version = "$Latest"
  }
}	

resource "aws_autoscaling_policy" "bat" {
  name                   = "cms_asg_policy"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.cms_asg.name}"
  policy_type 			 = "TargetTrackingScaling"
  target_tracking_configuration {
	predefined_metric_specification {
		predefined_metric_type = "ASGAverageCPUUtilization"
	}

		target_value = 40.0
  }
  
}


resource "aws_lb" "cms_lb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.lb_sg.id}"]
  subnets            = ["${aws_subnet.public.*.id}"]

  enable_deletion_protection = true
}

resource "aws_lb_target_group" "cms_target_grp" {
  name     = "cms_target_group"
  port     = 80
  protocol = "HTTP"
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_lb_target_group.test.arn}"
  target_id        = "${aws_instance.cms_lb.id}"
  port             = 80
}


resource "aws_autoscaling_attachment" "cms_asg_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.cms_asg.id}"
  alb_target_group_arn   = "${aws_alb_target_group.cms_target_grp.arn}"
}
