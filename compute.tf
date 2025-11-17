resource "oci_core_instance" "openvpn_instance" {
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  display_name        = "openvpn-server"
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id        = oci_core_subnet.vpn_subnet.id
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.openvpn_images.images[0].id
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }
}
