module "hello_world" {
  source = "../"

  name = "test-hello-world"

  ecs_image  = "vad1mo/hello-world-rest"
  ecs_cpu    = 256
  ecs_memory = 512
  tags = {
    "application" = "hello-world-rest"
  }
}