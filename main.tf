terraform {
  required_version = ">= 1.3.6"
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.89.0"
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

resource "snowflake_role" "this" {
  name = "${snowflake_warehouse.this.name}_ACCESS"
}

resource "snowflake_resource_monitor" "this" {
  name = var.resource_monitor

  credit_quota = var.credit_quota
}

resource "snowflake_warehouse_grant" "this" {
  depends_on = [snowflake_role.this]
  for_each   = local.access_types

  warehouse_name         = snowflake_warehouse.this.name
  privilege              = each.key
  enable_multiple_grants = var.enable_multiple_grants
  roles                  = [snowflake_role.this.name]
  with_grant_option      = var.with_grant_option
}
