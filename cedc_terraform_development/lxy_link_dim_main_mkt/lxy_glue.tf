module "aws_glue_job_target" {
    source = "../../cedc-terraform-generic-modules/modules/glue"
    name = "cedc-s3-read-s3-data-glue-job-xy"
    role_arn = glue_to_s3_iam_role.arn

    command {
      script_location = "glue pyspark 在s3上的路径"
    }
}