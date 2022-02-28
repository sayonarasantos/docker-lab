#/bin/bash

FILE_NAME="${DATABASE}-$(date +%Y-%m-%d-%H-%M).sql"


notification ()
{
	status=$1
    
    curl --location \
	--request POST "${CHAT_WEBHOOK}" \
    --header 'Content-Type: application/json' \
    --data-raw '{"text": "Task: '"$APP"' database backup. \r\nStatus: '"$status"'."}'
}


main ()
{
	printf '####################\n'
	date
	exit_status=1

	if [[ -z "$DB_HOST" || -z "$DB_PORT" || -z "$DB_USER" || -z "$DB_PASSWORD" || -z "$DATABASE" ]]; then
		printf 'ERROR: one or more database variables are undefined\n\n\n'
		notification 'Failed'
		exit 1
	else
		printf '########## Start mysql dump...\n'
		mysqldump --host="$DB_HOST" --port="$DB_PORT" --user="$DB_USER" --password="$DB_PASSWORD" "$DATABASE" > "$FILE_NAME"
	fi
	
	if [ "$?" -eq 0 ]; then
		printf '########## Start sending file to S3...\n'
		gzip $FILE_NAME && aws s3 cp ${FILE_NAME}.gz s3://${S3_BUCKET}/${DATABASE}/
		exit_status=$?
		rm -f ${FILE_NAME}*
	else
		printf 'ERROR: Backup did not work.\n\n\n'
		notification 'Failed'
		exit 1
	fi

	printf '########## Send notification.\n'
	if [ $exit_status -eq 0 ]; then
		printf 'Backup performed successfully.\n\n\n'
		notification 'Success'
		exit 0
	else
		printf 'ERROR: Backup did not work.\n\n\n'
		notification 'Failed'
		exit 1
	fi	
}


main
