# -----------------------------------------------------------------------------
# Provider and version configuration
# -----------------------------------------------------------------------------
terraform {
  # NOTE: The S3 backend configuration is provided via a GitLab variable.
  # Comment this to use the local backend.
  backend s3 {}
}
