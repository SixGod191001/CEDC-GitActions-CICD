resource "aws_databrew_recipe" "example_recipe" {
  name         = var.recipe_name
  recipe_steps = <<EOF
[
  {
    "action": "header",
    "parameters": {
      "datasetColumns": "Txn_Date,Customer_Id,Product_Id,Quantity,Total_Sales",
      "headerRow": "true"
    }
  },
  {
    "action": "rename_column",
    "parameters": {
      "newColumnName": "Product_Id4",
      "oldColumnName": "Product_Id"
    }
  }
]
EOF
}