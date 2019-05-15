FROM ruby:2.6.3-alpine3.8
ENV LANG C.UTF-8

RUN apk update && \
    apk upgrade && \
    apk add build-base mariadb-dev mariadb-client=~10.2 nodejs tzdata

ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock

ENV BUNDLE_PATH /usr/local/bundler

RUN gem install bundler && \
    cd /tmp && \
    bundle install && \
    rm -rf /tmp/*

WORKDIR /rails

RUN wget https://github.com/eficode/wait-for/raw/master/wait-for -O /bin/wait-for && chmod +x /bin/wait-for

CMD ["bundle", "exec", "rails", "server", "--binding", "0.0.0.0"]
