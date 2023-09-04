module "example_ruleset" {
  source = "../../../cedc_terraform_generic_modules/modules/databrew_ruleset"

  ruleset_description = "Sales ruleset"
  ruleset_name        = "youqun Sales Checks"

  rules               = [
    {
      check_expression = ":col > :val"
      column_selectors = null
      disabled         = false
      name             = "Total Sales should be >0"
      substitution_map = [
        {
         value_reference = ":val"
         value           = "0"
        },
        {
         value_reference = ":col"
         value           = "`total_sales`"
        }
       ]
      threshold        = null
    }
  ]
  tags = [
    {
      key   = "Project"
      value = "CEDC"
    }
  ]
  region       = "ap-northeast-1"
  dataset_name = "haohao-sales"
}