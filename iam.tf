# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS Task Execution Role
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "ecs_task_execution_role" {
    name               = "${var.name_preffix}-ecs-task-execution-role"
    assume_role_policy = "${file("${path.module}/files/iam/ecs_task_execution_iam_role.json")}"
}
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attach" {
  role       = "${aws_iam_role.ecs_task_execution_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS Auto Scale Role
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "ecs_autoscale_role" {
    name               = "${var.name_preffix}-ecs-autoscale-role"
    assume_role_policy = "${file("${path.module}/files/iam/ecs_autoscale_iam_role.json")}"
}
resource "aws_iam_role_policy" "ecs_autoscale_role_policy" {
    name   = "${var.name_preffix}-ecs-autoscale-role-policy"
    role   = "${aws_iam_role.ecs_autoscale_role.id}"
    policy = "${file("${path.module}/files/iam/ecs_autoscale_iam_role_policy.json")}"
}
