module "lambda_layer" {
  source              = "../../cedc_terraform_generic_modules/modules/lambda_layer_version"
  filename            = file("${path.module}/utils.zip")
  layer_name          = "common"
  compatible_runtimes = ["python3.9"]
  source_code_hash    = filesha256("${path.module}/utils.zip")

}
