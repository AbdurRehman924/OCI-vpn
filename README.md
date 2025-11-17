# OpenVPN Access Server on Oracle Cloud Infrastructure

Deploy OpenVPN Access Server on OCI free tier using Terraform.

## Prerequisites

1. OCI CLI configured (`oci setup config`)
2. Terraform installed
3. SSH key pair generated

## Quick Deploy

1. **Configure variables:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your tenancy OCID
   ```

2. **Deploy:**
   ```bash
   terraform init
   terraform apply
   ```

## Access

- **Admin:** `https://<public_ip>:943/admin`
- **Client:** `https://<public_ip>:943`
- **SSH:** `ssh openvpnas@<public_ip>`

Default admin: `openvpn` / `<instance_id>`

## Cleanup

```bash
terraform destroy
```
