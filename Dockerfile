FROM bitnami/ruby:2.6.6-debian-10-r29

# Deploying requirements
RUN install_packages rsync openssh-client

# Ruby base template
COPY Gemfile* /app/
COPY vendor/cache /app/vendor/cache
WORKDIR /app

# Install all the dependencies
RUN gem install bundler --version 1.17.3 && bundle install

CMD ["irb"]
