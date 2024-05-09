variable "warehouse_name" {
  type        = string
  description = "Name of the Warehouse you want to make"
}

variable "credit_quota" {
  type        = number
  description = "Credit Quota for Warehouse"
  default     = 100
}

variable "warehouse_comment" {
  type        = string
  description = "Comment for the warehouse or added description of warehouse"
  default     = ""
}

variable "warehouse_type" {
  type        = string
  description = "Specifies a STANDARD or SNOWPARK-OPTIMIZED warehouse"
  default     = "STANDARD"
}

variable "warehouse_size" {
  type        = string
  description = "Specifies the size of the virtual warehouse. Larger warehouse sizes 5X-Large and 6X-Large are currently in preview and only available on Amazon Web Services (AWS)."
  default     = "X-SMALL"
}

variable "auto_resume" {
  type        = bool
  description = "Specifies whether to automatically resume a warehouse when a SQL statement (e.g. query) is submitted to it."
  default     = true
}

variable "auto_suspend" {
  type        = number
  description = "Specifies the number of seconds of inactivity after which a warehouse is automatically suspended."
  default     = 200
}

variable "max_cluster_count" {
  type        = number
  description = "Specifies the maximum number of server clusters for the warehouse."
  default     = "2"
}

variable "max_concurrency_level" {
  type        = number
  description = "Object parameter that specifies the concurrency level for SQL statements (i.e. queries and DML) executed by a warehouse."
  default     = 8
}

variable "min_cluster_count" {
  type        = number
  description = "Specifies the minimum number of server clusters for the warehouse (only applies to multi-cluster warehouses)."
  default     = "1"
}

variable "query_acceleration_max_scale_factor" {
  type        = number
  description = "Specifies the maximum scale factor for leasing compute resources for query acceleration. The scale factor is used as a multiplier based on warehouse size."
  default     = "3"
}

variable "resource_monitor" {
  type        = string
  description = "Specifies the name of a resource monitor that is explicitly assigned to the warehouse."
}

variable "statement_queued_timeout_in_seconds" {
  type        = number
  description = "Specifies the time, in seconds, after which a running SQL statement (query, DDL, DML, etc.) is canceled by the system"
  default     = 3600
}

variable "statement_timeout_in_seconds" {
  type        = number
  description = "Specifies the time, in seconds, after which a running SQL statement (query, DDL, DML, etc.) is canceled by the system"
  default     = 3600
}

variable "enable_multiple_grants" {
  type        = bool
  description = "When this is set to true, multiple grants of the same type can be created. This will cause Terraform to not revoke grants applied to roles and objects outside Terraform."
  default     = true
}

variable "with_grant_option" {
  type        = bool
  description = "When this is set to true, allows the recipient role to grant the privileges to other roles."
  default     = false
}
