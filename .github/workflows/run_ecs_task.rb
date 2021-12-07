require "aws-sdk-ecs"

ECS_CLUSTER="deploy-cluster"

client = Aws::ECS::Client.new

run_task_response = client.run_task({
  launch_type: "FARGATE",
  cluster: ECS_CLUSTER,
  task_definition: ENV.fetch("ECS_TASK_DEFINITION"),
  network_configuration: {
    awsvpc_configuration: {
      subnets: [ENV.fetch("ECS_SUBNET")],
      assign_public_ip: "ENABLED",
      security_groups: ["sg-0166b518264c0af1a"]
    }
  },
  overrides: {
    container_overrides: [
      name: "cap-deploy",
      environment: [
        { "name" => "EC2_SSH_KEY", "value" => ENV.fetch("EC2_SSH_KEY") }
      ]
    ]
  }

})

wait_while = ["PROVISIONING", "PENDING", "ACTIVATING", "RUNNING"]
loop do
  task = client.describe_tasks(cluster: ECS_CLUSTER, tasks: [run_task_response.tasks.first.task_arn]).tasks.first
  sleep 2
  return unless wait_while.include?(task.last_status)
end
