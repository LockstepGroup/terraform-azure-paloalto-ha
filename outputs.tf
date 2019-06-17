// primary
output "primary_pa_mgmt_ip_address" {
  value = "${module.primary_pa.mgmt_ip}"
}
output "primary_pa_inside_ip_address" {
  value = "${module.primary_pa.inside_ip}"
}
output "primary_pa_outside_ip_address" {
  value = "${module.primary_pa.outside_ip}"
}
output "primary_pa_outside_public_ip_address" {
  value = "${module.primary_pa.outside_pip}"
}

// secondary
output "secondary_pa_mgmt_ip_address" {
  value = "${module.secondary_pa.mgmt_ip}"
}
output "secondary_pa_inside_ip_address" {
  value = "${module.secondary_pa.inside_ip}"
}
output "secondary_pa_outside_ip_address" {
  value = "${module.secondary_pa.outside_ip}"
}
output "secondary_pa_outside_public_ip_address" {
  value = "${module.secondary_pa.outside_pip}"
}
