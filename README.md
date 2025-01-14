<img align="right" width="60" height="60" src="images/terraform.png">

# terraform-snowflake-warehouses module

This is a repository that makes a warehouse with bare-minimum specs with the following defaults:

- Clustering
- Size X-SMALL
- Query Limitations and Timeouts
- Query Acceleration
- Warehouse Type Standard

Example CICD with `BitBucket` and `Codefresh`:

![Image](./images/diagram.png)

## NOTES

**`WARNING`**: 

- BREAKING CHANGES OCCUR FROM **`0.11.0`** TO **`0.12.0`** THE SNOWFLAKE PROVIDER VERSON UPGRADES FROM 93.X.X TO 1.0.1 HAD SOME CHANGES IN THE OVERALL NAMING CONVENTIONS AND LOGIC FOR MAKINMG WAREHOUSE ROLES

## Usage

To use the module you will need to use the following:

```hcl
module "snowflake_warehouse_bi" {
  source = "git::https://github.com/Richard-Barrett/terraform-snowflake-warehouses.git?ref=0.0.1"

  warehouse_name    = "BI"
  warehouse_comment = "Business Intelligences Warehouse"    # Optional
}
```

Required Values:

| Values         |
|----------------|
| warehouse_name |
| resource_monitor |

What if you want to specify specific components in the warehouse?

```hcl
module "snowflake_warehouse_bi" {
  source  = "git::https://github.com/Richard-Barrett/terraform-snowflake-warehouses.git?ref=0.0.1"

  warehouse_size    = "medium"
  warehouse_name    = "BI"
  warehouse_comment = "Business Intelligences Warehouse"    # Optional
  resource_monitor  = "BI"                                  # Optional
}
```

In the above we reference the following fields in addition to the required field `warehouse_name`:

- `warehouse_size`: The size of the warehouse
- `warehouse_comment`: A description for the Warehouse
- `resource_monitor`: A resource monitor for the warehouse getting created

## Overview

In overview, this repository acts as a digestible module that allows you to create a warehouse, the warehouse role, and the warehouse grant.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_snowflake"></a> [snowflake](#requirement\_snowflake) | ~> 1.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_snowflake"></a> [snowflake](#provider\_snowflake) | 1.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [snowflake_account_role.this](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/account_role) | resource |
| [snowflake_grant_privileges_to_account_role.this](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_account_role) | resource |
| [snowflake_resource_monitor.this](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/resource_monitor) | resource |
| [snowflake_warehouse.this](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/warehouse) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_resume"></a> [auto\_resume](#input\_auto\_resume) | Specifies whether to automatically resume a warehouse when a SQL statement (e.g. query) is submitted to it. | `bool` | `true` | no |
| <a name="input_auto_suspend"></a> [auto\_suspend](#input\_auto\_suspend) | Specifies the number of seconds of inactivity after which a warehouse is automatically suspended. | `number` | `200` | no |
| <a name="input_credit_quota"></a> [credit\_quota](#input\_credit\_quota) | Credit Quota for Warehouse | `number` | `100` | no |
| <a name="input_max_cluster_count"></a> [max\_cluster\_count](#input\_max\_cluster\_count) | Specifies the maximum number of server clusters for the warehouse. | `number` | `"2"` | no |
| <a name="input_max_concurrency_level"></a> [max\_concurrency\_level](#input\_max\_concurrency\_level) | Object parameter that specifies the concurrency level for SQL statements (i.e. queries and DML) executed by a warehouse. | `number` | `8` | no |
| <a name="input_min_cluster_count"></a> [min\_cluster\_count](#input\_min\_cluster\_count) | Specifies the minimum number of server clusters for the warehouse (only applies to multi-cluster warehouses). | `number` | `"1"` | no |
| <a name="input_query_acceleration_max_scale_factor"></a> [query\_acceleration\_max\_scale\_factor](#input\_query\_acceleration\_max\_scale\_factor) | Specifies the maximum scale factor for leasing compute resources for query acceleration. The scale factor is used as a multiplier based on warehouse size. | `number` | `"3"` | no |
| <a name="input_resource_monitor"></a> [resource\_monitor](#input\_resource\_monitor) | Specifies the name of a resource monitor that is explicitly assigned to the warehouse. | `string` | n/a | yes |
| <a name="input_statement_queued_timeout_in_seconds"></a> [statement\_queued\_timeout\_in\_seconds](#input\_statement\_queued\_timeout\_in\_seconds) | Specifies the time, in seconds, after which a running SQL statement (query, DDL, DML, etc.) is canceled by the system | `number` | `3600` | no |
| <a name="input_statement_timeout_in_seconds"></a> [statement\_timeout\_in\_seconds](#input\_statement\_timeout\_in\_seconds) | Specifies the time, in seconds, after which a running SQL statement (query, DDL, DML, etc.) is canceled by the system | `number` | `3600` | no |
| <a name="input_warehouse_comment"></a> [warehouse\_comment](#input\_warehouse\_comment) | Comment for the warehouse or added description of warehouse | `string` | `""` | no |
| <a name="input_warehouse_name"></a> [warehouse\_name](#input\_warehouse\_name) | Name of the Warehouse you want to make | `string` | n/a | yes |
| <a name="input_warehouse_size"></a> [warehouse\_size](#input\_warehouse\_size) | Specifies the size of the virtual warehouse. Larger warehouse sizes 5X-Large and 6X-Large are currently in preview and only available on Amazon Web Services (AWS). | `string` | `"X-SMALL"` | no |
| <a name="input_warehouse_type"></a> [warehouse\_type](#input\_warehouse\_type) | Specifies a STANDARD or SNOWPARK-OPTIMIZED warehouse | `string` | `"STANDARD"` | no |
| <a name="input_with_grant_option"></a> [with\_grant\_option](#input\_with\_grant\_option) | When this is set to true, allows the recipient role to grant the privileges to other roles. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Snowflake Role that is used to access the warehouse that the module creates |
<!-- END_TF_DOCS -->
