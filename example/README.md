# Example Deployment

Use a typical Terraform workflow:

```shell
terraform init
terraform plan
terraform apply
```

Once deployed, the endpoint for the load balancer will be output and can be used
to test.

Example with `curl`:

```plain
❯ curl http://test-hello-world-415814420.us-west-2.elb.amazonaws.com                                                                                                               master ✚ ◼
/ - Hello World! Host:ip-172-31-28-11.us-west-2.compute.internal/172.31.28.11
```
