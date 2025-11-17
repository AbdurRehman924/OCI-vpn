output "openvpn_public_ip" {
  description = "Public IP of OpenVPN server"
  value       = oci_core_instance.openvpn_instance.public_ip
}

output "openvpn_admin_url" {
  description = "OpenVPN Admin URL"
  value       = "https://${oci_core_instance.openvpn_instance.public_ip}:943/admin"
}

output "openvpn_client_url" {
  description = "OpenVPN Client URL"
  value       = "https://${oci_core_instance.openvpn_instance.public_ip}:943"
}
