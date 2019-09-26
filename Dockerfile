from elixir:latest
RUN apt-get update && apt-get install -y postgresql-client zsh vim
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN useradd web && mkdir /home/web && chown web /home/web
USER web
COPY ./build.sh /build.sh
RUN sh /build.sh
WORKDIR /src/app
CMD /bin/zsh
