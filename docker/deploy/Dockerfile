FROM ruby:2.7.2

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN mkdir ~/.ec2 && \
  bundle install --jobs $(nproc) --retry 5
COPY . /app
