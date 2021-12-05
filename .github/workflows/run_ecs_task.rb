require "aws-sdk-ecs"

CLUSTER="deploy-cluster"
# TASK_DEFINITION="capistrano-deploy-staging:14"
SUBNETS=["subnet-2210f56b"]

client = Aws::ECS::Client.new

run_task_response = client.run_task({
  launch_type: "FARGATE",
  cluster: CLUSTER,
  task_definition: ENV.fetch("ECS_TASK_DEFINITION"),
  network_configuration: {
    awsvpc_configuration: {
      subnets: [ENV.fetch("ECS_SUBNET")],
      assign_public_ip: "ENABLED"
    }
  }

})

wait_while = ["PROVISIONING", "PENDING", "ACTIVATING", "RUNNING"]
loop do
  task = client.describe_tasks(cluster: "deploy-cluster", tasks: [run_task_response.tasks.first.task_arn]).first
  sleep 2
  return unless wait_while.include?(task.last_status)
end
