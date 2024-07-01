# Create IAM User
resource "aws_iam_user" "sqs_user" {
  name = "sqs_user"
}

# Create IAM Policy
resource "aws_iam_policy" "sqs_access_policy" {
  name        = "sqs_access_policy"
  description = "Policy to allow access to the SQS queue"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ]
        Effect   = "Allow"
        Resource = aws_sqs_queue.home_loan_queue.arn
      }
    ]
  })
}

# Attach Policy to User
resource "aws_iam_user_policy_attachment" "sqs_user_policy_attachment" {
  user       = aws_iam_user.sqs_user.name
  policy_arn = aws_iam_policy.sqs_access_policy.arn
}


resource "aws_sqs_queue" "home_loan_dead_letter_queue" {
  name = "home_loan_dead_letter_queue"
}

resource "aws_sqs_queue_redrive_allow_policy" "home_loan_dead_letter_queue" {
  queue_url = aws_sqs_queue.home_loan_dead_letter_queue.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.home_loan_queue.arn]
  })
}

resource "aws_sqs_queue" "home_loan_queue" {
  name                      = "home_loan_queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.home_loan_dead_letter_queue.arn
    maxReceiveCount     = 4
  })
}
