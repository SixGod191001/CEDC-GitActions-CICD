resource "aws_glue_connection" "glue_connection" {
  connection_properties = {
    JDBC_CONNECTION_URL = var.jdbc_url
    PASSWORD            = var.password
    USERNAME            = var.username
  }

  name = var.connection_name
}
