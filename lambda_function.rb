def lambda_handler(event:, context:)
  results = {}

  environment = event["environment"]

  system("ls")
  system("bundle install -j4")

  results[:test] = "Hello!! - #{environment}"

  {
    results: results,
    event: event.inspect,
    context: context.inspect
  }
end
