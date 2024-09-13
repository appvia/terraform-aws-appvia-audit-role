![Github Actions](../../actions/workflows/terraform.yml/badge.svg)

# Terraform AWS Appvia Audit Role

## Description

This module creates a federated AWS IAM role in one or more accounts for the purpose of providing remote audit access
for Appvia. The module should be deployed from the organization management account or a delegated administrator account.

The role is designed as such that it can only be consumed from a coresponding audit role within Appvia's infrastructure
and when an agreed external ID is in place. Once the audit is complete, this role should be removed, however it will automatically
block further access after 7 days.

## Usage

Add example usage here

```hcl
module "example" {
  source  = "appvia/appvia-audit-role/aws"
  version = "1.0.0"

  external_id = "<random secure id>"

  deployment_account_ids = [
    "012345678910",
    "102938475632",
  ]

  expiry_days = 7
}
```

## Update Documentation

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:

1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.12.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack.management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_cloudformation_stack_set.member_accounts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set) | resource |
| [aws_cloudformation_stack_set_instance.member_accounts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance) | resource |
| [time_offset.expiry](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/offset) | resource |
| [aws_organizations_organization.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_account_ids"></a> [deployment\_account\_ids](#input\_deployment\_account\_ids) | List of account IDs in which to deploy the remote audit access role | `list(string)` | n/a | yes |
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | External ID should be a string of cryptographically safe random characters | `string` | n/a | yes |
| <a name="input_appvia_role_arn"></a> [appvia\_role\_arn](#input\_appvia\_role\_arn) | Allows specifying a non-standard IAM role. Only set this if asked to do so by Appvia | `string` | `"arn:aws:iam::730335310409:role/aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_WAFSupport_19c9bc61106389c3"` | no |
| <a name="input_expiry_days"></a> [expiry\_days](#input\_expiry\_days) | The number of days the role is available before access will be denied | `number` | `14` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
