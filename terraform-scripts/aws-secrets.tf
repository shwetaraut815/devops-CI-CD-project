variable "rds_secret_name" {
  description = "Name of the pre-created Secrets Manager secret"
  type        = string
  default     = "rds-mysql-credentials" # change if different
}

data "aws_secretsmanager_secret" "rds_secret" {
  name = var.rds_secret_name
}

data "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = data.aws_secretsmanager_secret.rds_secret.id
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)
}
