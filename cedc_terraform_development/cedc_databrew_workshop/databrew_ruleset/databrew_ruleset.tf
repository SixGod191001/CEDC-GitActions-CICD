module "example_ruleset" {
  source = "../../../cedc_terraform_generic_modules/modules/databrew_ruleset"

  ruleset_description = "Sales role set"
  ruleset_name        = "youqunSalesRuleset"
  rules               = [
    {
      check_expression = "total_sales > 0" # Data quality check
      column_selectors = [
        {
          name  = "total_sales"
          regex = null
        }
      ]
      disabled         = false
      name             = "SalesCheck"
      substitution_map = null
      threshold = {
        type  = "GREATER_THAN" # threshold.type value must be one of: ["GREATER_THAN_OR_EQUAL" "LESS_THAN_OR_EQUAL" "GREATER_THAN" "LESS_THAN"]
        unit  = "PERCENTAGE" # threshold.unit value must be one of: ["COUNT""PERCENTAGE"]
        value = 90.0
      }
    }
  ]
  tags = [
    {
      key   = "Project"
      value = "CEDC"
    }
  ]
  region       = "ap-northeast-1"
  dataset_name = "youqun-sales"

 }