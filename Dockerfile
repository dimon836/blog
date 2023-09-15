FROM ruby:3.2.2-bullseye as base

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev patch zlib1g-dev liblzma-dev postgresql-client nodejs

ENV APP_HOME /blog

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/

ENV BUNDLE_PATH=/bundle \
  BUNDLE_BIN=/bundle/bin \
  GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

RUN gem install bundler && bundle install

COPY . $APP_HOME

RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["./docker-entrypoint.sh"]

CMD [ "bundle","exec", "puma", "config.ru"]
