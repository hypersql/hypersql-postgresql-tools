FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# packages
RUN apt-get update -y && apt-get upgrade -y                                    \
    && apt-get install -y vim wget gnupg2 sudo lsb-release net-tools curl

# user
# TODO add supernova to postgres group
RUN adduser --disabled-password --gecos "" postgres \
    && usermod -aG sudo postgres \
    && echo "postgres  ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers

USER postgres

# postgresql 11
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/postgresql-pgdg.list \
    && sudo apt-get update \
    && sudo apt-get install postgresql-11 postgresql-contrib-11 -y 

WORKDIR /home/postgres

COPY entrypoint.sh /home/postgres
ENTRYPOINT ["/home/postgres/entrypoint.sh"]

