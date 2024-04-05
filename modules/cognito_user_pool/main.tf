
variable "SNS_email_id" {
  description = "Name of the security group"
}

variable "cognito_user_pool_name" {
  description = "Name for new cognito userpool "
}

data "aws_ses_email_identity" "SES_EMAIL_ARN" {
  email = var.SNS_email_id
}

resource "aws_cognito_user_pool" "pool" {
  name = var.cognito_user_pool_name

  auto_verified_attributes = ["email"]
  
  password_policy {
    minimum_length = 8
    require_lowercase = true
    require_numbers = true
    require_symbols = true
    require_uppercase = true
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_LINK"
    email_subject_by_link  = "${var.cognito_user_pool_name} Account Confirmation"
    email_message_by_link = "Please confirmation email by this link {##Click Here##}"
  }

  account_recovery_setting {
    recovery_mechanism {
      name = "verified_email"
      priority = 1
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  email_configuration {
    email_sending_account = "DEVELOPER"
    source_arn = data.aws_ses_email_identity.SES_EMAIL_ARN.arn
  }
}

resource "aws_cognito_user_pool_domain" "pool_domain" {
  domain = var.cognito_user_pool_name # Choose a unique prefix for your Cognito domain
  user_pool_id = aws_cognito_user_pool.pool.id
}



resource "aws_cognito_user_pool_client" "app_client" {
  name = "${var.cognito_user_pool_name}-client"
  user_pool_id = aws_cognito_user_pool.pool.id
  generate_secret = false

  callback_urls = [
    "https://${var.cognito_user_pool_name}-login",
    "https://${var.cognito_user_pool_name}-logout",
  ]

  allowed_oauth_flows    = ["code"]
  allowed_oauth_scopes   = ["openid", "profile", "email"]
  default_redirect_uri   = "https://${var.cognito_user_pool_name}-login"

  supported_identity_providers = ["COGNITO"]
  allowed_oauth_flows_user_pool_client = true

  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
  ]

}


output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}

output "cognito_user_pool_arn" {
  value = aws_cognito_user_pool.pool.arn
}

output "cognito_user_pool_domain" {
  value = aws_cognito_user_pool_domain.pool_domain.domain
}

output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool_client.app_client.id
}

output "cognito_user_pool_client_name" {
  value = aws_cognito_user_pool_client.app_client.name
}
