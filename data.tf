# -----------------------------------------------------------------------------
# Common data lookups
# -----------------------------------------------------------------------------
data "aws_region" "current" {}
data "aws_vpc" "current" {}

data "aws_subnets" "current" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.current.id]
  }
}
