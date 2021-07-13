FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /PDCA_app
WORKDIR /PDCA_app

COPY Gemfile /PDCA_app/Gemfile
COPY Gemfile.lock /PDCA_app/Gemfile.lock

RUN bundle install
COPY . /PDCA_app