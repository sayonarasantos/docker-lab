# docker-lab

Repositório para armazenar modelos de imagens e composes Docker, tanto para entrega como para desenvolvimento.

- image-by-language/java/spring-boot: imagem para **entrega** de aplicação Spring Boot.

    ```
    docker image build -t app:spring-boot .
    ```


- image-by-language/javascript/angular: imagem para **entrega** de aplicação Angular.

    ```
    docker image build -t app:angular .
    ```


- image-by-language/javascript/nodejs/docker-compose.dev.yml: compose para **desenvolvimento** de aplicação NodeJS.
    
    ```
    docker-compose up -d
    docker exec -it nodejs-dev sh
    ```


- image-by-language/javascript/nodejs/docker-compose.prod.yml: compose para **entrega** de aplicação NodeJS.
    
    ```
    docker-compose up -d
    docker exec -it nodejs-dev sh
    ```


- image-by-language/javascript/react-native: imagem para **entrega** de apk de aplicação em React Native.
    
    ```
    docker image build -t app:react-native .
    docker container run -td -v ${PWD}/:/app/ --name builder app:react-native
    docker container exec builder yarn
    ```


- image-by-language/python: 

    - Dockerfile.pip: imagem para **entrega** de aplicação Python simples.

    - Dockerfile.poetry: imagem para **entrega** de aplicação Python com Poetry.

    ```
    docker image build -t app:python-poetry --build-arg POETRY_VERSION=1.1.7 -f Dockerfile.poetry .
    ```


- pgadmin-postgres: compose **entrega** de os serviços Pgadmin e Postgres.

    ```
    docker-compose up -d
    ```


- python-mssql: imagens para **entrega** de aplicação Python com Mssql Tools.

    ```
    docker image build -t app:python-mssql-alpine -f Dockerfile.alpine .
    ```


- teampass: compose para **entrega** do Teampass, com banco, proxy e certificado HTTPS.
    
    ```
    docker-compose up -d
    ```