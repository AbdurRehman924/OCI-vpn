data "oci_identity_availability_domains" "ads" {
  compartment_id = local.compartment_id
}

data "oci_core_images" "openvpn_images" {
  compartment_id   = local.compartment_id
  operating_system = "OpenVPN Access Server"
  state           = "AVAILABLE"
  
  filter {
    name   = "display_name"
    values = ["OpenVPN Access Server*"]
    regex  = true
  }
}
