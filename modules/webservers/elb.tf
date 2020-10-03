data "aws_subnet" "default" {                                   
  availability_zone = "eu-west-3"
  
}

resource "aws_lb" "web-lb" {
    name                = "web-ELB"
    load_balancer_type  = "application"
    subnets             = data.aws_subnet.default.ids
    depends_on          = [aws_instance.ph-1-web_nodes]
}

  resource "aws_lb" "haproxy-lb" {
    name                = "haproxy-ELB"
    load_balancer_type  = "network"
    subnets             = data.aws_subnet.default.ids
    internal            = true
    depends_on          = [aws_instance.haproxy_nodes]
  }

resource "aws_lb_target_group" "web-nodes" {
  name     = "web-targets"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    port                = 6000
    path                = "/health.html"
    protocol            = "HTTP"
    interval            = 30
    matcher             = "200"
  }

}

  resource "aws_lb_target_group" "haproxy-nodes" {
    name     = "haproxy-targets"
    port     = 80
    protocol = "TCP"
    vpc_id   = data.aws_vpc.default.id
  }


resource "aws_lb_listener" "TCP-80" {
  load_balancer_arn = aws_lb.web-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-nodes.arn
  }
}

  resource "aws_lb_listener" "TCP-8080" {
    load_balancer_arn = aws_lb.web-lb.arn
    port              = "8080"
    protocol          = "HTTP"

    default_action {
      type = "redirect"

      redirect {
        port        = "80"
        protocol    = "HTTP"
        status_code = "HTTP_301"
      }
    }
  }

  resource "aws_lb_listener" "HP-80" {
    load_balancer_arn = aws_lb.haproxy-lb.arn
    port              = "80"
    protocol          = "TCP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.haproxy-nodes.arn
    }
  }

resource "aws_lb_target_group_attachment" "web-nodes" {
  count            = var.web_nodes_count
  target_group_arn = aws_lb_target_group.web-nodes.arn
  target_id        = element(aws_instance.web_nodes.*.id,  count.index)
  port             = 5000
}

  resource "aws_lb_target_group_attachment" "haproxy-nodes" {
    count            = var.haproxy_nodes_count
    target_group_arn = aws_lb_target_group.haproxy-nodes.arn
    target_id        = element(aws_instance.haproxy_nodes.*.id,  count.index)
    port             = 80
  }
