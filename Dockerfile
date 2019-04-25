FROM ruby:2.4

# System prerequisites
RUN apt-get update \
 && apt-get -y install build-essential libpq-dev \
 && rm -rf /var/lib/apt/lists/*

# If you require additional OS dependencies, install them here:
# RUN apt-get update \
#  && apt-get -y install imagemagick nodejs \
#  && rm -rf /var/lib/apt/lists/*

ADD Gemfile /app/
ADD Gemfile.lock /app/
WORKDIR /app
RUN bundle install

ADD . /app
RUN bundle exec rake assets:precompile


# Collect assets. This approach is not fully production-ready, but
# will help you experiment with Enclave before bothering with assets.
# Review http://go.aptible.com/assets for production-ready advice.



ENV PORT 3000
EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"]
