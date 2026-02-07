#! /usr/bin/env sh

ADMIN_USER_ROLE='Administrator'
NUXT_USER_ROLE='API'

# Create the initial admin user
if [[ ! -z "$ADMIN_EMAIL" ]] && [[ ! -z "$ADMIN_PASSWORD" ]] && [[ ! -z "$DB_FILENAME" ]]; then
	if [[ -f "$DB_FILENAME" ]]; then

		ADMIN_FIRST_NAME=${ADMIN_FIRST_NAME:=Admin}
		ADMIN_LAST_NAME=${ADMIN_LAST_NAME:=User}

		# Check for existing admin user
		user_id=$(sqlite3 "$DB_FILENAME" "SELECT id FROM directus_users WHERE email = '$ADMIN_EMAIL'")
		if [[ -z "$user_id" ]]; then

			# Create new admin user
			echo "--> Creating Admin User [$ADMIN_EMAIL]"
			role_id=$(sqlite3 "$DB_FILENAME" "SELECT id FROM directus_roles WHERE name = '$ADMIN_USER_ROLE'")
			node /directus/cli.js users create --email "$ADMIN_EMAIL" --password "$ADMIN_PASSWORD" --role "$role_id"

			# Update name
			echo "--> Updating Admin User Name [$ADMIN_FIRST_NAME $ADMIN_LAST_NAME]"
			sqlite3 "$DB_FILENAME" "UPDATE directus_users SET first_name = '$ADMIN_FIRST_NAME', last_name = '$ADMIN_LAST_NAME', last_page = '/content/details' WHERE email = '$ADMIN_EMAIL'"

			# Disable setup user
			echo "--> Disabling initial setup user"
			sqlite3 "$DB_FILENAME" "UPDATE directus_users SET status = 'archived' WHERE email = 'setup@example.com'"

		else
			echo "--> Admin user already exists, skipping"
		fi

	else
		echo "ERROR: DB Not Found! [$DB_FILENAME]"
	fi
else
	echo "--> WARNING: No admin email and password set!"
fi


# Create the NUXT API user for the site
if [[ ! -z "$NUXT_DIRECTUS_TOKEN" ]] && [[ ! -z "$DB_FILENAME" ]]; then
	if [[ -f "$DB_FILENAME" ]]; then

		NUXT_USER_EMAIL=${NUXT_USER_EMAIL:=nuxt@example.com}
		NUXT_USER_PASSWORD=${NUXT_USER_PASSWORD:=$(head -c 32 /dev/urandom | xxd -p -c 32)}
		NUXT_USER_FIRST_NAME=${NUXT_USER_FIRST_NAME:=Nuxt}
		NUXT_USER_LAST_NAME=${NUXT_USER_LAST_NAME:=API}

		# Check for existing nuxt user
		user_id=$(sqlite3 "$DB_FILENAME" "SELECT id FROM directus_users WHERE email = '$NUXT_USER_EMAIL'")
		if [[ -z "$user_id" ]]; then

			# Create new nuxt user
			echo "--> Creating Nuxt User [$NUXT_USER_EMAIL]"
			echo "    Generated Password: $NUXT_USER_PASSWORD"
			role_id=$(sqlite3 "$DB_FILENAME" "SELECT id FROM directus_roles WHERE name = '$NUXT_USER_ROLE'")
			node /directus/cli.js users create --email "$NUXT_USER_EMAIL" --password "$NUXT_USER_PASSWORD" --role "$role_id"

			# Update name
			echo "--> Updating Nuxt User Name [$NUXT_USER_FIRST_NAME $NUXT_USER_LAST_NAME]"
			sqlite3 "$DB_FILENAME" "UPDATE directus_users SET first_name = '$NUXT_USER_FIRST_NAME', last_name = '$NUXT_USER_LAST_NAME' WHERE email = '$NUXT_USER_EMAIL'"

		else
			echo "--> Nuxt User already exists, skipping"
		fi

		# Update Nuxt User Token
		existing_token=$(sqlite3 "$DB_FILENAME" "SELECT token FROM directus_users WHERE email = '$NUXT_USER_EMAIL'")
		if [[ "$existing_token" != "$NUXT_DIRECTUS_TOKEN" ]]; then
			echo "--> Updating Nuxt User Token"
			sqlite3 "$DB_FILENAME" "UPDATE directus_users SET token = '$NUXT_DIRECTUS_TOKEN' WHERE email = '$NUXT_USER_EMAIL'"
		else
			echo "--> Nuxt User Token already exists, skipping"
		fi

	else
		echo "ERROR: DB Not Found! [$DB_FILENAME]"
	fi
else
	echo "--> WARNING: No nuxt directus token set!"
fi

echo "--> Starting Directus..."
node /directus/cli.js bootstrap && pm2-runtime start ecosystem.config.cjs