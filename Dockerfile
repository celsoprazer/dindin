FROM ruby:3.3.0

# Instala dependências essenciais
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client

WORKDIR /app

# Copia e instala as gems
COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app

# Inicia o servidor
CMD ["rails", "server", "-b", "0.0.0.0"]