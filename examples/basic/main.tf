module "example" {
  source = "../../"

  # A secure random string to be used as the role's external ID.
  # This should only be shared between the client and Appvia.
  external_id = "b03e124b514528288a38cb791de17bde"

  # List of account IDs that the role should be deployed to
  deployment_account_ids = [
    "012345678910",
    "102938475632",
  ]

  # The number of days after which an account should expire
  expiry_days = 7
}
