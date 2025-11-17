locals {
  compartment_id = var.compartment_id != "" ? var.compartment_id : var.tenancy_ocid
}
