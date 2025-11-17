data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

data "oci_core_images" "oracle_linux" {
  compartment_id   = var.compartment_id
  operating_system = "Oracle Linux"
  state           = "AVAILABLE"
  
  filter {
    name   = "display_name"
    values = ["Oracle-Linux-8.*-aarch64-.*"]
    regex  = true
  }
}
