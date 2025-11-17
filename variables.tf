variable "region" {
  description = "OCI region"
  default     = "us-phoenix-1"
}

variable "compartment_id" {
  description = "OCI compartment OCID"
}

variable "instance_shape" {
  description = "Instance shape"
  default     = "VM.Standard.E2.1.Micro"
}

variable "ssh_public_key_path" {
  description = "SSH public key path"
  default     = "~/.ssh/id_rsa.pub"
}
