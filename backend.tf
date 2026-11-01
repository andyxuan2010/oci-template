# Supply bucket, namespace, region, and a unique state key during terraform init.
# Credentials belong in OCI backend environment variables or a local OCI profile.
terraform {
  backend "oci" {}
}
