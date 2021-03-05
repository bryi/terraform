
output "prod_public_subnet_ids" {
  value = module.vpc-prod.public_subnet_ids
}

output "prod_private_subnet_ids" {
  value = module.vpc-prod.private_subnet_ids
}

output "security_group_id" {
  value = module.security_group.security_group_id
}

output "security_group_elb_id" {
  value = module.security_group_elb.security_group_id
}
