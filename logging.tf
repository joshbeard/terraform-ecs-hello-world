# -----------------------------------------------------------------------------
# Log Configuration
# -----------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "log_group" {
  name = var.name
  tags = merge(var.tags, { "Name" = var.name })
}
