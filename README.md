# OpenVPN on Oracle Cloud (Free Tier)

## Setup

1. Configure OCI CLI: `oci setup config`
2. Copy config: `cp terraform.tfvars.example terraform.tfvars`
3. Edit `terraform.tfvars` with your tenancy OCID
4. Deploy: `terraform init && terraform apply`

## Access

- Admin: `https://<ip>:943/admin`
- Client: `https://<ip>:943`
- SSH: `ssh openvpnas@<ip>`

Default login: `openvpn` / `<instance_id>`

## Cleanup

`terraform destroy`
