resource "oci_core_vcn" "vpn_vcn" {
  compartment_id = local.compartment_id
  cidr_blocks    = ["10.0.0.0/16"]
  display_name   = "vpn-vcn"
}

resource "oci_core_internet_gateway" "vpn_igw" {
  compartment_id = local.compartment_id
  vcn_id         = oci_core_vcn.vpn_vcn.id
  display_name   = "vpn-igw"
}

resource "oci_core_route_table" "vpn_rt" {
  compartment_id = local.compartment_id
  vcn_id         = oci_core_vcn.vpn_vcn.id
  display_name   = "vpn-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.vpn_igw.id
  }
}

resource "oci_core_subnet" "vpn_subnet" {
  compartment_id      = local.compartment_id
  vcn_id              = oci_core_vcn.vpn_vcn.id
  cidr_block          = "10.0.1.0/24"
  display_name        = "vpn-subnet"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  route_table_id      = oci_core_route_table.vpn_rt.id
  security_list_ids   = [oci_core_security_list.vpn_sl.id]
}
