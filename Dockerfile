FROM ruby:2.6.3

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends apt-transport-https

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" / | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends nodejs yarn

ENV APP_HOME /app
RUN mkdir $APP_HOME
COPY Gemfile* $APP_HOME/
WORKDIR $APP_HOME

RUN bundle install

COPY . $APP_HOME/

# CMD ["bin/rails","server","-b","0.0.0.0"]