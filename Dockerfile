ARG BUNDLE_PATH=/bundle
ARG RAILS_ENV=development

FROM ruby:3.1.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs
RUN npm install -g yarn

RUN mkdir /mixtape
WORKDIR /mixtape
ADD Gemfile /mixtape/Gemfile
ADD Gemfile.lock /mixtape/Gemfile.lock
RUN bundle install
ADD . /mixtape
