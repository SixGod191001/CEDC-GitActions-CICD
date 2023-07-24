module "aws_glue_job" {
    source = "../../cedc-terraform-generic-modules/modules/glue"
    name = "cedc-s3-read-s3-data-glue-job-xy"
    role_arn = " glue的arn"

    command {
      script_location = "glue pyspark 在s3上的路径"
    }
}