def lambda_handler(event:, context:)
  results = {}

  environment = event["environment"]

  system("bundle config set --local /mnt/bundle && bundle install -j4")
  results[:test] = "Hello!! - #{environment}"

  {
    results: results,
    event: event.inspect,
    context: context.inspect
  }
end
