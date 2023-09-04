# module "databrew_dataset" {
#   source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
#   name           = "elaine-customers"
#   bucket         = "gitaction-s3-terraform"
#   key            = "elaine_cedc_databrew_workshop/datafiles/customers/customers.csv"
# }
#
# module "databrew_dataset_sales" {
#   source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
#   name           = "elaine-sales"
#   bucket         = "gitaction-s3-terraform"
#   key            = "elaine_cedc_databrew_workshop/datafiles/sales/sales.csv"
# }