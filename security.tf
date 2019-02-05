# ---------------------------------------------------------------------------------------------------------------------
# AWS Security Groups - Control Access to ALB
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "lb_sg" {
    name        = "${var.name_preffix}-lb-sg"
    description = "Control access to LB"
    vpc_id      = "${var.vpc_id}"
    ingress {
        protocol    = "tcp"
        from_port   = 80
        to_port     = 80
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        protocol  = "-1"
        from_port = 0
        to_port   = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "${var.name_preffix}-lb-sg"
    }
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Security Groups - ECS Tasks, allow traffic only from Load Balancer
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "ecs_tasks_sg" {
    name        = "${var.name_preffix}-ecs-tasks-sg"
    description = "Allow inbound access from the LB only"
    vpc_id      = "${var.vpc_id}"
    ingress {
        protocol        = "tcp"
        from_port       = "${var.container_port}"
        to_port         = "${var.container_port}"
        security_groups = ["${aws_security_group.lb_sg.id}"]
    }
    egress {
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "${var.name_preffix}-ecs-tasks-sg"
    }
}
