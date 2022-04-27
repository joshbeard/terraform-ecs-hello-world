# -----------------------------------------------------------------------------
# ECS Fargate Deployment of hello-world-rest
#
# * ECS Cluster
# * ECS Service
# * ECS Task Definition
# -----------------------------------------------------------------------------

resource "aws_ecs_cluster" "hello" {
  name = var.name

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_service" "hello" {
  name            = var.name
  cluster         = aws_ecs_cluster.hello.id
  task_definition = aws_ecs_task_definition.hello.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = module.alb.target_group_arns[0]
    container_name   = "hello-world-rest"
    container_port   = var.container_port
  }

  network_configuration {
    subnets         = data.aws_subnets.current.ids
    security_groups = [aws_security_group.hello_backend.id]
    # For the demo, attach a public IP. The VPC does not have
    # a gateway.
    assign_public_ip = true
  }

  tags = var.tags
}

resource "aws_ecs_task_definition" "hello" {
  family = var.name

  # Refer to https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html
  # for cpu and memory values
  cpu    = var.ecs_cpu
  memory = var.ecs_memory

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  execution_role_arn = aws_iam_role.ecs_service.arn
  task_role_arn      = aws_iam_role.ecs_task.arn

  tags = var.tags

  container_definitions = jsonencode([
    {
      name      = "hello-world-rest"
      image     = var.ecs_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.log_group.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
