# Terraform CodePipeline+CodeBuilder for ECS Service

## Example:
    module "codepipeline" {
        source                      = "./modules/codepipeline"
        region                      = "${var.region}"
        name                        = "name"
        bucket_artifact_store       = "bucket"
        repository_url              = "${module.ecs.repository_url}"
        ecs_service_name            = "${module.ecs.service_name}"
        ecs_cluster_name            = "${module.ecs.cluster_name}"
        run_task_subnet_id          = "${module.vpc.private_subnets[0]}"
        run_task_security_group_ids = [
            "${module.vpc.default_security_group_id}",
            "${module.ecs.security_group_id}"
        ]
        source-repository-owner      = "${var.source-repository-owner}"
        source-repository-repo       = "${var.source-repository-repo}"
        source-repository-branch     = "${var.source-repository-branch}"
        source-repository-folder     = "${var.source-repository-folder}"
        source-repository-provider = ""
    }
