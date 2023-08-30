module "example_ruleset" {
  source = "../../../cedc_terraform_generic_modules/modules/databrew_ruleset"

  ruleset_description = "Sales rule set"
  ruleset_name        = "Haohao Sales DQ Checks"

  rules               = [
    {
      check_expression = "duplicate rows count == 0" # Data quality check
      column_selectors = [
        {
          name  = null
          regex = null
        }
      ]
      disabled         = false
      name             = "Duplicate rows"
      substitution_map = null
      threshold = {
        type  = null # threshold.type value must be one of: ["GREATER_THAN_OR_EQUAL" "LESS_THAN_OR_EQUAL" "GREATER_THAN" "LESS_THAN"]
        unit  = null # threshold.unit value must be one of: ["COUNT""PERCENTAGE"]
        value = null
      }
    }
  ]

  region       = "ap-northeast-1"
  dataset_name = "haohao-sales"
}
