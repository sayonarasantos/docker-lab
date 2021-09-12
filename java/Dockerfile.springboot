# STAGE 1: Build app

FROM maven:3-openjdk-11-slim AS builder

RUN mkdir /project
WORKDIR /project

COPY . .
RUN mvn clean package -DskipTests


# STAGE 2: Deploy app

FROM openjdk:11-jre-slim

ARG USER_NAME=lady
ARG USER_HOME=/project

RUN useradd --system --home $USER_HOME $USER_NAME \
    && mkdir -p $USER_HOME \
    && chown -R $USER_NAME:$USER_NAME $USER_HOME
USER $USER_NAME
WORKDIR $USER_HOME

COPY --from=builder --chown=$USER_NAME:$USER_NAME /project/target/*.jar $USER_HOME/app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","./app.jar"]
