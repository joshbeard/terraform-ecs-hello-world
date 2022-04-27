# -----------------------------------------------------------------------------
# Input Variables
# -----------------------------------------------------------------------------
variable "name" {
  description = "A name to use for resources."
  type        = string
}

variable "ecs_cpu" {
  description = "The CPU count for the ECS task."
  type        = number
  default     = 256
}

variable "ecs_memory" {
  description = "The memory count for the ECS task."
  type        = number
  default     = 512
}

variable "ecs_image" {
  description = "The Docker image to use for the ECS task."
  type        = string
  default     = "vad1mo/hello-world-rest"
}

variable "container_port" {
  description = "The TCP port the container is listening on."
  type        = number
  default     = 5050
}

variable "permissions_boundary" {
  description = "The ARN of an IAM permissions boundary to use for creating IAM resources."
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of common tags to apply to resources."
  type        = map(any)
  default     = {}
}