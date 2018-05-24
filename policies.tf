// CodePipeline
resource "aws_iam_role" "codepipeline_role" {
  name               = "${var.name}_codepipeline_role"
  assume_role_policy = "${file("${path.module}/policies/codepipeline_role.json")}"
}

data "template_file" "codepipeline_policy" {
  template = "${file("${path.module}/policies/codepipeline_policy.json")}"
  vars {
    aws_s3_bucket_arn = "${aws_s3_bucket.source.arn}"
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "${var.name}_codepipeline_policy"
  role   = "${aws_iam_role.codepipeline_role.id}"
  policy = "${data.template_file.codepipeline_policy.rendered}"
}

// CodeBuild
resource "aws_iam_role" "codebuild_role" {
  name               = "${var.name}_codebuild_role"
  assume_role_policy = "${file("${path.module}/policies/codebuild_role.json")}"
}

data "template_file" "codebuild_policy" {
  template = "${file("${path.module}/policies/codebuild_policy.json")}"
  vars {
    aws_s3_bucket_arn = "${aws_s3_bucket.source.arn}"
  }
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name        = "${var.name}_codebuild_policy"
  role        = "${aws_iam_role.codebuild_role.id}"
  policy      = "${data.template_file.codebuild_policy.rendered}"
}
