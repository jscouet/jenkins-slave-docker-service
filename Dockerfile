FROM jenkins/jnlp-slave:3.19-1
MAINTAINER Jeremy Soude <jsoude@tuta.io>
LABEL Description="Jenkins slave with tools" Vendor="jsoude" Version="3.19"

ARG VERSION=3.19-1
ARG COMPOSE_VERSION=1.20.1

USER root


RUN apt-get update
RUN apt-get install apt-transport-https
RUN echo 'deb https://download.docker.com/linux/debian stretch stable' >>  /etc/apt/sources.list
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-get update
RUN apt-get install -y ansible docker-ce
RUN curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
USER jenkins

# docker run  --rm  --network service --name=slave-service --hostname=slave-service jsoude/jenkins-jnlp-slave -url https://jenkins.${MYDOMAIN}:443  -workDir=/home/jenkins/agent {{ jenkins_code }}  service
