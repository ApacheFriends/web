FROM ruby:2.6.6-buster

# Deploying requirements


# Ruby base template
COPY Gemfile* /app/
COPY vendor/cache /app/vendor/cache
WORKDIR /app

# Install all the dependencies
RUN gem install bundler --version 1.17.3 && bundle install

CMD ["irb"]
