FROM ruby:2.6.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler:2.1.2
COPY Gemfile* $APP_HOME/
RUN bundle config set without 'development test'
RUN bundle install

COPY . $APP_HOME/

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails","server","-b","0.0.0.0"]

RUN RAILS_ENV=production bundle exec rake assets:precompile
