resource "time_offset" "expiry" {
  offset_days = var.expiry_days
}

resource "aws_cloudformation_stack" "management" {
  count = local.deploy_to_management ? 1 : 0

  name          = "AppviaAuditRole"
  template_body = local.template_body
  on_failure    = "ROLLBACK"

  capabilities = [
    "CAPABILITY_NAMED_IAM",
    "CAPABILITY_AUTO_EXPAND",
    "CAPABILITY_IAM",
  ]

  parameters = {
    AppviaRoleARN     = var.appvia_role_arn
    ExternalID        = var.external_id
    ExpiryDate        = time_offset.expiry.rfc3339
    ManagedPolicyArns = join(",", var.managed_policy_arns)
  }

  lifecycle {
    ignore_changes = [
      capabilities,
    ]
  }
}

resource "aws_cloudformation_stack_set" "member_accounts" {
  name             = "AppviaAuditRole"
  description      = "Provisions federated IAM role allowing Appvia remote audit access"
  template_body    = local.template_body
  permission_model = "SERVICE_MANAGED"

  capabilities = [
    "CAPABILITY_NAMED_IAM",
    "CAPABILITY_AUTO_EXPAND",
    "CAPABILITY_IAM",
  ]

  parameters = {
    AppviaRoleARN     = var.appvia_role_arn
    ExternalID        = var.external_id
    ExpiryDate        = time_offset.expiry.rfc3339
    ManagedPolicyArns = join(",", var.managed_policy_arns)
  }

  auto_deployment {
    enabled                          = true
    retain_stacks_on_account_removal = false
  }

  lifecycle {
    ignore_changes = [
      administration_role_arn,
      capabilities,
    ]
  }
}

resource "aws_cloudformation_stack_set_instance" "member_accounts" {
  count = length(var.deployment_account_ids) > 0 ? 1 : 0

  stack_set_name = aws_cloudformation_stack_set.member_accounts.name

  deployment_targets {
    account_filter_type = "INTERSECTION"
    accounts            = local.member_account_ids

    organizational_unit_ids = [
      data.aws_organizations_organization.current.roots[0].id,
    ]
  }
}
