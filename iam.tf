# -----------------------------------------------------------------------------
# IAM Resources
#
# Manages IAM resources for hello-world-rest:
#   * Policy and role for ECS Service
#   * Policy and role for ECS Task
# -----------------------------------------------------------------------------

# == ECS Service
data "aws_iam_policy_document" "ecs_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com",
        "ecs.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "ecs_service" {
  statement {
    actions = [
      "ecs:DeregisterContainerInstance",
      "ecs:RegisterContainerInstance",
      "ecs:Submit*",
    ]

    resources = [aws_ecs_cluster.hello.arn]
  }

  statement {
    actions = [
      "ecs:UpdateContainerInstancesState",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "ecs:cluster"
      values   = [aws_ecs_cluster.hello.arn]
    }
  }

  statement {
    actions = [
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:StartTelemetrySession",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["${aws_cloudwatch_log_group.log_group.arn}:*"]
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
    ]

    resources = ["*"]
  }

}

resource "aws_iam_role" "ecs_service" {
  name                 = "${var.name}-ecs-service"
  assume_role_policy   = data.aws_iam_policy_document.ecs_assume_role_policy.json
  permissions_boundary = var.permissions_boundary
}

resource "aws_iam_policy" "ecs_service" {
  name   = "${var.name}-ecs-service-policy"
  policy = data.aws_iam_policy_document.ecs_service.json
}

resource "aws_iam_role_policy_attachment" "ecs_service" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.ecs_service.arn
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerServiceRole" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

# == ECS Task
resource "aws_iam_role" "ecs_task" {
  name                 = "${var.name}-ecs-task"
  assume_role_policy   = data.aws_iam_policy_document.ecs_assume_role_policy.json
  permissions_boundary = var.permissions_boundary

  tags = merge(var.tags, { "Name" = "${var.name}-ecs-task" })
}

data "aws_iam_policy_document" "task_execution" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["${aws_cloudwatch_log_group.log_group.arn}:*"]
  }
}

resource "aws_iam_policy" "task_execution" {
  name   = "${var.name}-task-execution-policy"
  policy = data.aws_iam_policy_document.task_execution.json

  tags = merge(var.tags, { "Name" = "${var.name}-task-execution" })
}

resource "aws_iam_role_policy_attachment" "task_execution" {
  role       = aws_iam_role.ecs_task.name
  policy_arn = aws_iam_policy.task_execution.arn
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole" {
  role       = aws_iam_role.ecs_task.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
