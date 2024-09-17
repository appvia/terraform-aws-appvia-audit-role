variable "appvia_role_arn" {
  type        = string
  default     = "arn:aws:iam::730335310409:role/aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_WAFSupport_19c9bc61106389c3"
  description = "Allows specifying a non-standard IAM role. Only set this if asked to do so by Appvia"
}

variable "deployment_account_ids" {
  type        = list(string)
  description = "List of account IDs in which to deploy the remote audit access role"
}

variable "external_id" {
  type        = string
  description = "External ID should be a string of cryptographically safe random characters"
}

variable "expiry_days" {
  type        = number
  default     = 14
  description = "The number of days the role is available before access will be denied"
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "List of managed AWS policy ARNs to apply to the role"

  default = [
    "arn:aws:iam::aws:policy/SecurityAudit",
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
  ]
}
