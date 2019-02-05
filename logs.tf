# ---------------------------------------------------------------------------------------------------------------------
# AWS Cloudwatch Logs
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "log_group" {
    name              = "${lookup(local.log_options, "awslogs-group")}"
    retention_in_days = "7"
    tags {
        Name = "${lookup(local.log_options, "awslogs-group")}"
    }
}
resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "${lookup(local.log_options, "awslogs-group")}"
  log_group_name = "${aws_cloudwatch_log_group.log_group.name}"
}