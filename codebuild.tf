data "template_file" "buildspec" {
  template = "${file("${path.module}/buildspec.yml")}"

  vars {
    repository_url            = "${var.repository_url}"
    source_repository_folder  = "${var.source-repository-folder}"
    region                    = "${var.region}"
    cluster_name              = "${var.ecs_cluster_name}"
    subnet_id                 = "${var.run_task_subnet_id}"
    security_group_ids        = "${join(",", var.run_task_security_group_ids)}"
  }
}

resource "aws_codebuild_project" "${var.name}_build" {
  name          = "${var.name}_codebuild"
  build_timeout = "10"
  service_role  = "${aws_iam_role.codebuild_role.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    // https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html    // https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    image           = "aws/codebuild/docker:1.12.1"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "${data.template_file.buildspec.rendered}"
  }
}