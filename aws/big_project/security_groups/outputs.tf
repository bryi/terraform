output "ELB_SG_ID" {
  value = module.security_group_elb.security_group_id
}

output "ELB_SERVERS_SG_ID" {
  value = module.security_group_elb_server.security_group_id
}

output "SERVERS_SG_ID" {
  value = module.security_group_servers.security_group_id
}

output "BASTION_SG_ID" {
  value = module.security_group_bastion.security_group_id
}

output "SERVERS_DB_SG_ID" {
  value = module.security_group_servers_db.security_group_id
}

output "SERVERS_CACHE_SG_ID" {
  value = module.security_group_servers_cache.security_group_id
}