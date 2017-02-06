FROM mwallasch/docker-ruby-node:latest

#EXPOSE 3000

WORKDIR /
COPY ./run-project.sh /run-project.sh

ENTRYPOINT ["sh", "/run-project.sh"]
