#! /usr/bin/env sh


if [[ ! -z "$ADMIN_EMAIL" ]] && [[ ! -z "$ADMIN_PASSWORD" ]] && [[ ! -z "$DB_FILENAME" ]]; then
	if [[ -f "$DB_FILENAME" ]]; then

		# Check for existing admin user
		user_id=$(sqlite3 "$DB_FILENAME" "SELECT id FROM directus_users WHERE email = '$ADMIN_EMAIL'")
		if [[ -z "$user_id" ]]; then

			# Create new admin user
			echo "--> Creating Admin User [$ADMIN_EMAIL]"
			role_id=$(sqlite3 "$DB_FILENAME" "SELECT id FROM directus_roles WHERE name = 'Administrator'")
			node /directus/cli.js users create --email "$ADMIN_EMAIL" --password "$ADMIN_PASSWORD" --role "$role_id"

			# Update name
			fn=${ADMIN_FIRST_NAME:=Admin}
			ln=${ADMIN_LAST_NAME:=User}
			echo "--> Updating Admin User Name [$fn $ln]"
			sqlite3 "$DB_FILENAME" "UPDATE directus_users SET first_name = '$fn', last_name = '$ln' WHERE email = '$ADMIN_EMAIL'"

			# Disable setup user
			echo "--> Disabling initial setup user"
			sqlite3 "$DB_FILENAME" "UPDATE directus_users SET status = 'archived' WHERE email = 'webmaster@davidwaring.net'"

		else
			echo "--> Admin user already exists, skipping"
		fi

	else
		echo "ERROR: DB Not Found! [$DB_FILENAME]"
	fi
else
	echo "--> WARNING: No admin email and password set!"
fi

echo "--> Starting Directus..."
node /directus/cli.js bootstrap && pm2-runtime start ecosystem.config.cjs