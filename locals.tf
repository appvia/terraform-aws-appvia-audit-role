locals {
  # CloudFormation template
  template_body = file("${path.module}/cloud_formation/role.yaml")

  # Lookup the management account ID from org data
  management_account_id = data.aws_organizations_organization.current.master_account_id

  # Member accounts are any provided accounts that are not the management account
  member_account_ids = [
    for v in var.deployment_account_ids : v if v != local.management_account_id
  ]

  # If the management account is in the list, this evaluates to true
  deploy_to_management = contains(var.deployment_account_ids, local.management_account_id)
}
