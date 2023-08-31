module "example_ruleset" {
  source = "../../../cedc_terraform_generic_modules/modules/databrew_ruleset"

  ruleset_description = "Sales rule set"
  ruleset_name        = "Haohao Sales DQ Checks"

  rules               = [
    {
      # check_expression = "AGG(DUPLICATE_VALUES_COUNT) <:val" # Data quality check  duplicate rows count == 0
      check_expression = AGG(MISSING_VALUES_PERCENTAGE) == :val1
      column_selectors = null
      disabled         = false
      name             = "Check missing value"
      substitution_map = [
        {
          value_reference = ":val1"
          value           = '0'
        }
      ]
      threshold        = null
    }
  ]

  region       = "ap-northeast-1"
  dataset_name = "haohao-sales"
}
