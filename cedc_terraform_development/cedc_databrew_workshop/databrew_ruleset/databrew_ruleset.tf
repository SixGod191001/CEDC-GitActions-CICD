module "example_ruleset" {
  source = "../../../cedc_terraform_generic_modules/modules/databrew_ruleset"

  ruleset_description = "Sales role set"
  ruleset_name        = "JackySalesRuleset"
  rules               = [
    {
      check_expression = "total_sales > 0"
      column_selectors = [
        {
          name  = "total_sales"
          regex = "^[0-9]+(\\.[0-9]+)?$"
        }
      ]
      disabled         = false
      name             = "SalesCheck"
      substitution_map = [
        {
          value           = "sales"
          value_reference = "dataset_name"
        }
      ]
      threshold = {
        type  = "GREATER_THAN"
        unit  = "PERCENTAGE" # Attribute rules[0].threshold.unit value must be one of: ["COUNT""PERCENTAGE"]
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
  dataset_name = "sales"
  dependencies = ["cedc_terraform_development/cedc_databrew_iam_common", "cedc_terraform_development/cedc_databrew_workshop/databrew_dataset"]
}