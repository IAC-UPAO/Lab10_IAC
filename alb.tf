resource "aws_lb" "lab10_alb" {
    name = "${var.project_name}-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.lab10_alb_sg.id]
    subnets = [aws_subnet.lab10_subnet_az1.id, aws_subnet.lab10_subnet_az2.id]
    enable_deletion_protection = false
    tags = {
        Name = "${var.project_name}-alb"
    }
}

resource "aws_lb_target_group" "app1_tg" {
    name = "${var.project_name}-app1-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.lab10_vpc.id

    health_check {
        enabled = true
        interval = 30
        path = "/"
        port = "traffic-port"
        timeout = 5
        healthy_threshold = 2
        unhealthy_threshold = 2
        matcher = "200"
    }

    tags = {
        Name = "${var.project_name}-app1-tg"
    }
}

resource "aws_lb_target_group" "app2_tg" {
    name = "${var.project_name}-app2-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.lab10_vpc.id

    health_check {
        enabled = true
        interval = 30
        path = "/"
        port = "traffic-port"
        timeout = 5
        healthy_threshold = 2
        unhealthy_threshold = 2
        matcher = "200"
    }

    tags = {
        Name = "${var.project_name}-app2-tg"
    }
}

resource "aws_lb_target_group_attachment" "app1_attachment" {
    target_group_arn = aws_lb_target_group.app1_tg.arn
    target_id = aws_instance.instance_app1.id
    port = 80
}

resource "aws_lb_target_group_attachment" "app2_attachment" {
    target_group_arn = aws_lb_target_group.app2_tg.arn
    target_id = aws_instance.instance_app2.id
    port = 80
}

resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.lab10_alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      forward {
        target_group {
          arn = aws_lb_target_group.app1_tg.arn
          weight = 70
        }
        target_group {
          arn = aws_lb_target_group.app2_tg.arn
          weight = 30
        }
      }
    }

    tags = {
      Name = "${var.project_name}-listener"
    }
}