# docker-lab

Repositório para armazenar modelos de imagens e composes Docker, tanto para entrega (produção) como para desenvolvimento (local).

## Lista dos modelos

- [image-by-language/java/spring-boot](image-by-language/java/spring-boot): imagem para **entrega** de aplicação Spring Boot

- [image-by-language/javascript/angular](image-by-language/javascript/angular): imagem para **entrega** de aplicação Angular

- [image-by-language/javascript/nodejs/docker-compose.dev.yml](image-by-language/javascript/nodejs/docker-compose.dev.yml): compose para **desenvolvimento** de aplicação NodeJS

- [image-by-language/javascript/nodejs/docker-compose.prod.yml](image-by-language/javascript/nodejs/docker-compose.prod.yml): compose para **entrega** de aplicação NodeJS

- [image-by-language/javascript/react-native](image-by-language/javascript/react-native): imagem para **entrega** de apk de aplicação em React Native

- [image-by-language/python/python-mssql](image-by-language/python/python-mssql): imagens para **entrega** de aplicação Python com acesso a banco SQL Server

- [image-by-language/python/Dockerfile.pip](image-by-language/python/Dockerfile.pip): imagem para **entrega** de aplicação Python com o gerenciador de pacotes pip

- [image-by-language/python/Dockerfile.poetry](image-by-language/python/Dockerfile.poetry): imagem para **entrega** de aplicação Python com o gerenciador de pacotes Poetry

- [pgadmin-postgres](pgadmin-postgres): compose para ambiente de **desenvolvimento** com Pgadmin e Postgres

- [send-mysql-backup-to-s3](send-mysql-backup-to-s3): automatização de backup de banco de dados MySQL e envio desse backup para AWS S3

- [teampass](teampass): compose para **entrega** do Teampass com banco, proxy e certificado HTTPS

- [wildfly-postgresql](wildfly-postgresql): imagem para entrega de aplicação Java que acessa um banco Postgres e que executa com WildFly
