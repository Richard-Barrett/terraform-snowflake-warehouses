output "role_name" {
  description = "Snowflake Role that is used to access the warehouse that the module creates"
  value       = snowflake_account_role.this.name
}
