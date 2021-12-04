FROM ruby:2.7.2

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install --jobs $(nproc) --retry 5
COPY . /app

CMD ["bundle", "exec", "cap", "staging", "deploy"]
