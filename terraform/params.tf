data "aws_secretsmanager_secret" "config_data" {
  name = "config_data"
}

data "aws_secretsmanager_secret_version" "secret_credentials" {
  secret_id = data.aws_secretsmanager_secret.config_data.id
}