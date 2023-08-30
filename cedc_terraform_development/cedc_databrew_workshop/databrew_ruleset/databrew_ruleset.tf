module "example_ruleset" {
  source = "../../../cedc_terraform_generic_modules/modules/databrew_ruleset"

  ruleset_description = "Sales rule set"
  ruleset_name        = "Haohao Sales DQ Checks"

  rules               = [
    {
      check_expression = "AGG(DUPLICATE_VALUES_COUNT, 'Quantity') == :val" # Data quality check  duplicate rows count == 0
      column_selectors = null
      disabled         = false
      name             = "Duplicate rows"
      substitution_map = [
        {
          value           = "10"
          value_reference = ":val"
        }
      ]
      threshold        = null
    }
  ]

  region       = "ap-northeast-1"
  dataset_name = "haohao-sales"
}
