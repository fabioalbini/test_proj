def lambda_handler(event:, context:)
  results = {}

  results[:test] = "Hello!!"

  {
    results: results,
    event: event.inspect,
    context: context.inspect
  }
end
