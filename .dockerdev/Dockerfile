FROM ruby:2.6

ARG BUNDLER_VERSION

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    nodejs \
    g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x \
    xvfb xauth
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV APP_USER app
ENV APP_USER_HOME /home/$APP_USER
ENV APP_HOME /home/www/bsdt

RUN useradd -m -d $APP_USER_HOME $APP_USER

WORKDIR $APP_HOME

RUN mkdir /var/www && \
    chown $APP_USER:$APP_USER /var/www && \
    chown -R $APP_USER:$APP_USER $APP_USER_HOME && \
    chown $APP_USER:$APP_USER $APP_HOME

USER $APP_USER

RUN gem install bundler -v $BUNDLER_VERSION

COPY --chown=app:app . .

CMD bundle exec puma -C config/puma.rb
