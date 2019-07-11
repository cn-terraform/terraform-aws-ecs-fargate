# ---------------------------------------------------------------------------------------------------------------------
# AWS Cloudwatch Logs
# ---------------------------------------------------------------------------------------------------------------------
module "aws_cw_logs" {
  source  = "jnonino/cloudwatch-logs/aws"
  version = "1.0.2"
  logs_path                   = local.log_options["awslogs-group"]
  profile                     = var.profile
  region                      = var.region
}

