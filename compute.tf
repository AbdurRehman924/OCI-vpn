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
    source_id   = data.oci_core_images.oracle_linux.images[0].id
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
    user_data = base64encode(<<-EOF
      #!/bin/bash
      yum update -y
      yum install -y wget
      wget https://as-repository.openvpn.net/as-repo-centos8.rpm
      rpm -Uvh as-repo-centos8.rpm
      yum install -y openvpn-as
      /usr/local/openvpn_as/bin/ovpn-init --batch
      EOF
    )
  }
}
