terraform {
  required_version = ">= 1.3.6"
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 1.0.1"
    }
  }
}

locals {
  access_types = toset([
    "USAGE",
    "OPERATE",
    "MONITOR"
  ])
}

resource "snowflake_warehouse" "this" {
  depends_on = [snowflake_resource_monitor.this]

  name                                = "${upper(var.warehouse_name)}_WH"
  comment                             = var.warehouse_comment
  warehouse_type                      = var.warehouse_type
  warehouse_size                      = var.warehouse_size
  auto_resume                         = var.auto_resume
  auto_suspend                        = var.auto_suspend
  max_cluster_count                   = var.max_cluster_count
  max_concurrency_level               = var.max_concurrency_level
  min_cluster_count                   = var.min_cluster_count
  query_acceleration_max_scale_factor = var.query_acceleration_max_scale_factor
  resource_monitor                    = snowflake_resource_monitor.this.name
  statement_queued_timeout_in_seconds = var.statement_queued_timeout_in_seconds
  statement_timeout_in_seconds        = var.statement_timeout_in_seconds
}

# Snowflake Role
resource "snowflake_account_role" "this" {
  name = "${snowflake_warehouse.this.name}_ACCESS"
}

# Snowflake Resource Monitor
resource "snowflake_resource_monitor" "this" {
  name         = var.resource_monitor
  credit_quota = var.credit_quota
}

# Grant Privileges to Account Role (replace deprecated snowflake_warehouse_grant)
resource "snowflake_grant_privileges_to_account_role" "this" {
  for_each = local.access_types

  account_role_name = snowflake_account_role.this.name
  privileges        = [each.key]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.this.name
  }
  with_grant_option = var.with_grant_option
}
