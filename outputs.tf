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
output "availability_set_id" {
  value = "${module.shared_resources.availability_set_id}"
}
