# OpenVPN Access Server on Oracle Cloud Infrastructure

This Terraform project deploys an OpenVPN Access Server instance on OCI.

## Prerequisites

1. OCI CLI configured with proper credentials
2. Terraform installed
3. SSH key pair generated

## Deployment

1. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your values:
   - `compartment_id`: Your OCI compartment OCID
   - `region`: Your preferred OCI region
   - `ssh_public_key_path`: Path to your SSH public key

3. Initialize and deploy:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Access

After deployment:
- Admin interface: `https://<public_ip>:943/admin`
- Client interface: `https://<public_ip>:943`
- SSH access: `ssh openvpnas@<public_ip>`

Default admin credentials: `openvpn` / `<instance_id>`

## Cleanup

```bash
terraform destroy
```
