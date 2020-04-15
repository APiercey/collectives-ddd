FROM ruby:2.7.1-alpine3.11
MAINTAINER Alexander Butt-Piercey <https://github.com/APiercey>

RUN apk update

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app
COPY Gemfile.lock /app

RUN bundle config set without 'development test'
RUN bundle install

COPY config.ru /app
COPY config/ /app/config
COPY lib/ /app/lib

CMD bundle exec rackup config.ru -p 80 -o 0.0.0.0
