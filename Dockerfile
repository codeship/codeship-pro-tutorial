# Start with the offical image for Ruby 2.2.2
FROM ruby:2.2.2

# Update the base system and install any required dependencies
RUN apt-get update -qq

# You could install further dependencies via e.g.
# RUN apt-get install \
#   apt-utils \
#   build-essential

# Create the folders needed by the application and set the current working
# directory for the following commands
RUN mkdir /app
WORKDIR /app

# Copy over the Gemfile and run bundle install.
# This is done as a separate steps so the image can be cached this step won't be
# rerun unless you change the Gemfile or Gemfile.lock
COPY Gemfile Gemfile.lock /app/
RUN bundle install --jobs 20 --retry 5

# Copy the complete application onto the container
COPY . /app
