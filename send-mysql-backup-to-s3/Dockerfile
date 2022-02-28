FROM debian:buster-slim as aws-installer

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends curl ca-certificates unzip \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install --bin-dir /aws-cli-bin/


FROM debian:buster-slim

COPY --from=aws-installer /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=aws-installer /aws-cli-bin/ /usr/local/bin/

RUN mkdir /project/script -p

WORKDIR /project

COPY ./mysql_pubkey.asc ./
COPY ./scripts/run-db-backup.sh ./script/

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends gnupg curl ca-certificates \
    && apt-key add mysql_pubkey.asc \
    && echo 'deb http://repo.mysql.com/apt/debian/ buster mysql-5.7' > /etc/apt/sources.list.d/mysql.list \
    && apt-get update -y \
    && apt-get install -y mysql-community-client \
    && rm -rf /var/lib/apt/lists/*
