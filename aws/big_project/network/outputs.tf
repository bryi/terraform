
output "prod_vpc_cidr" {
  value = module.vpc-prod.vpc_cidr
}
output "prod_public_subnet_ids" {
  value = module.vpc-prod.public_subnet_ids
}

output "prod_private_subnet_ids" {
  value = module.vpc-prod.private_subnet_ids
}

output "prod_db_subnet_ids" {
  value = module.vpc-prod.db_subnet_ids
}

