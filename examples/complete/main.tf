terraform {
  required_version = ">= 1.3.6"
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 1.0.1"
    }
  }
}

provider "snowflake" {}

module "snowflake_warehouse_test" {
  source = "../../"

  warehouse_name    = "TEST"
  warehouse_comment = "TEST Warehouse" # Optional
  resource_monitor  = "TEST"
}
