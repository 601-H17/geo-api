FROM mwallasch/docker-ruby-node:latest

#EXPOSE 3000

#Install dependencies
RUN bundle install

WORKDIR /
COPY ./docker/run-project.sh /run-project.sh

ENTRYPOINT ["sh", "/run-project.sh"]
