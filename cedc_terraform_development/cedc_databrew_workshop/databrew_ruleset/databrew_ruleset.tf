module "example_ruleset" {
  source = "../../../cedc_terraform_generic_modules/modules/databrew_ruleset"

  ruleset_description = "Sales rule set"
  ruleset_name        = "Haohao Sales DQ Checks"

  rules               = [
    {
      check_expression = "duplicate rows count == 0" # Data quality check
      column_selectors = null
      disabled         = false
      name             = "Duplicate rows"
      substitution_map = null
      threshold        = null
    }
  ]

  region       = "ap-northeast-1"
  dataset_name = "haohao-sales"
}
