# Mysql database backup

Descrição: automatizar realização backup de banco de dados MySQL e envio para AWS S3.


## Criar usuário para realizar backup

Entre na máquina do banco de dados e execute os sequintes comandos:

```console
mysql -u root -p
CREATE USER 'bkpuser' IDENTIFIED BY 'password';
GRANT ALL ON *.* TO 'bkpuser';
exit;
```


## Construir imagem Docker

Construa a imagem Docker na máquina hospedeira onde será executado o script de backup:

```console
cd send-mysql-backup-to-s3/
docker image build . -t mysql-s3-backup:latest
```

Crie um arquivo .env com as credenciais de banco, S3 e webhook. Copie o arquivo .env.model e digite os valores necessários:

```console
cp .env.model /usr/local/.env
nano /usr/local/.env
```

Teste a imagem:

```console
docker container run --rm --env-file /usr/local/.env mysql-s3-backup:latest bash /project/script/run-db-backup.sh
```


## Cadastre a atividade de backup no Crontab

Abra o arquivo de agendamento do cron:

```console
crontab -e
```

E adicione a atividade:

```
0 2 * * * docker container run --rm --env-file /usr/local/.env mysql-s3-backup:latest bash /project/script/run-db-backup.sh >> mysql_backup.log 2>&1
```
> Essa atividade será executada todos os dias às 2h.