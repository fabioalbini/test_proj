require "aws-sdk-ecs"

CLUSTER="deploy-cluster"
# TASK_DEFINITION="capistrano-deploy-staging:14"
SUBNETS=["subnet-2210f56b"]

client = Aws::ECS::Client.new

resp = client.run_task({
  launch_type: "FARGATE",
  cluster: CLUSTER,
  task_definition: ENV.fetch(:TASK_DEFINITION),
  network_configuration: {
    awsvpc_configuration: {
      subnets: SUBNETS,
      assign_public_ip: "ENABLED"
    }
  }
})
