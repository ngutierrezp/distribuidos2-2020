FROM ruby:2.7.1

RUN apt-get update     && apt-get install -y --no-install-recommends         nodejs postgresql-client     && rm -rf /var/lib/apt/lists/*

# Copy application files and install the bundle
WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle update rails
RUN gem install bundler -v 2.2.0
RUN bundle install
COPY . .

# Run asset pipeline.
RUN bundle exec rake db:migrate

EXPOSE 3000
CMD ["bundle", "exec", "rackup", "--port=8080", "--env=production"]
