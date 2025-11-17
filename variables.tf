variable "region" {
  description = "OCI region"
  type        = string
  default     = "us-phoenix-1"
}

variable "compartment_id" {
  description = "OCI compartment OCID (use tenancy OCID if no custom compartment)"
  type        = string
}

variable "instance_shape" {
  description = "Instance shape"
  type        = string
  default     = "VM.Standard.E2.1.Micro"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
