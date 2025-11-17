terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 5.0"
    }
  }
}

provider "oci" {
  region = var.region
}

locals {
  compartment_id = var.compartment_id != "" ? var.compartment_id : var.tenancy_ocid
}

# Get availability domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = local.compartment_id
}

# Get OpenVPN image
data "oci_core_images" "openvpn_images" {
  compartment_id           = local.compartment_id
  operating_system         = "OpenVPN Access Server"
  operating_system_version = "2.14.3"
  shape                    = var.instance_shape
  state                    = "AVAILABLE"
}

# Create VCN
resource "oci_core_vcn" "vpn_vcn" {
  compartment_id = local.compartment_id
  cidr_blocks    = ["10.0.0.0/16"]
  display_name   = "vpn-vcn"
}

# Create Internet Gateway
resource "oci_core_internet_gateway" "vpn_igw" {
  compartment_id = local.compartment_id
  vcn_id         = oci_core_vcn.vpn_vcn.id
  display_name   = "vpn-igw"
}

# Create Route Table
resource "oci_core_route_table" "vpn_rt" {
  compartment_id = local.compartment_id
  vcn_id         = oci_core_vcn.vpn_vcn.id
  display_name   = "vpn-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.vpn_igw.id
  }
}

# Create Security List
resource "oci_core_security_list" "vpn_sl" {
  compartment_id = local.compartment_id
  vcn_id         = oci_core_vcn.vpn_vcn.id
  display_name   = "vpn-sl"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 443
      max = 443
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 943
      max = 943
    }
  }

  ingress_security_rules {
    protocol = "17"
    source   = "0.0.0.0/0"
    udp_options {
      min = 1194
      max = 1194
    }
  }
}

# Create Subnet
resource "oci_core_subnet" "vpn_subnet" {
  compartment_id      = local.compartment_id
  vcn_id              = oci_core_vcn.vpn_vcn.id
  cidr_block          = "10.0.1.0/24"
  display_name        = "vpn-subnet"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  route_table_id      = oci_core_route_table.vpn_rt.id
  security_list_ids   = [oci_core_security_list.vpn_sl.id]
}

# Create OpenVPN Instance
resource "oci_core_instance" "openvpn_instance" {
  compartment_id      = local.compartment_id
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
