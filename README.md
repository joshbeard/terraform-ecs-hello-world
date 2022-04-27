# Hello World ECS Fargate Deployment

This is a Terraform module and pipeline for deploying the
[vad1mo/hello-world-rest](https://github.com/Vad1mo/hello-world-rest)
application to ECS Fargate.

This deploys to the default VPC.

## Overview

The resources deployed include:

* ECS Fargate Cluster, Service, and Task definition
* Application Load Balancer for public HTTP access
* CloudWatch Log Group for ECS task logs
* AWS Security Groups (backend, frontend)
* IAM Roles and Policies for the ECS Service and Task

## Usage

Use the [example](example/) to test this module.

```shell
cd example
```

Typical Terraform workflow:

```shell
terraform init
terraform plan
terraform apply
```

There are 17 resources managed by this module.

```plain
Plan: 17 to add, 0 to change, 0 to destroy.
```

## Example Output

```plain
❯ curl http://test-hello-world-415814420.us-west-2.elb.amazonaws.com                                                                                                               master ✚ ◼
/ - Hello World! Host:ip-172-31-28-11.us-west-2.compute.internal/172.31.28.11
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.hello](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.hello](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.hello](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.AmazonEC2ContainerServiceRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecsTaskExecutionRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.hello_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.hello_frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_iam_policy_document.ecs_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnets.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The TCP port the container is listening on. | `number` | `5050` | no |
| <a name="input_ecs_cpu"></a> [ecs\_cpu](#input\_ecs\_cpu) | The CPU count for the ECS task. | `number` | `256` | no |
| <a name="input_ecs_image"></a> [ecs\_image](#input\_ecs\_image) | The Docker image to use for the ECS task. | `string` | `"vad1mo/hello-world-rest"` | no |
| <a name="input_ecs_memory"></a> [ecs\_memory](#input\_ecs\_memory) | The memory count for the ECS task. | `number` | `512` | no |
| <a name="input_name"></a> [name](#input\_name) | A name to use for resources. | `string` | n/a | yes |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The ARN of an IAM permissions boundary to use for creating IAM resources. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of common tags to apply to resources. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Development

This project uses [pre-commit](https://pre-commit.com/) to ensure that code
standard checks pass locally before pushing to the remote project repo. Follow
the installation instructions, then set up hooks with `pre-commit install`.

Run check everything:

```shell
pre-commit run --all
```

## Deployment

A [GitLab pipeline configuration](.gitlab-ci.yml) is included.

See <https://gitlab.com/joshbeard/terraform-ecs-hello-world/-/jobs/2386136970>
for an example of the GitLab pipeline.

## Authors

Josh Beard [josh@joshbeard.me](mailto:josh@joshbeard.me)
