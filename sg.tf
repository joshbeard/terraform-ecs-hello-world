# -----------------------------------------------------------------------------
# AWS Security Groups
# -----------------------------------------------------------------------------
resource "aws_security_group" "hello_backend" {
  name        = var.name
  description = "Allow connections to the ${var.name} backend"
  vpc_id      = data.aws_vpc.current.id

  #ingress {
  #  description = "${var.name} backend HTTP"
  #  from_port   = var.container_port
  #  to_port     = var.container_port
  #  protocol "tcp"
  #  cidr_blocks = [data.aws_vpc.current.cidr_block]
  #}

  ingress {
    description     = "Permit application access"
    security_groups = [aws_security_group.hello_frontend.id]
    to_port         = var.container_port
    from_port       = var.container_port
    protocol        = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { "Name" = "${var.name}-backend" })
}

resource "aws_security_group" "hello_frontend" {
  name        = "${var.name}-frontend"
  description = "Allow connections to the front-end HTTP"
  vpc_id      = data.aws_vpc.current.id

  ingress {
    description = "Permit Intranet HTTP access"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 80
    from_port   = 0
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { "Name" = "${var.name}-frontend" })
}