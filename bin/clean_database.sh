#! /usr/bin/env bash

DB_FILENAME="$1"

if [[ -z "$DB_FILENAME" ]]; then
    echo "ERROR: DB File not specified!"
    exit 1
fi
if [[ ! -f "$DB_FILENAME" ]]; then
    echo "ERROR: DB File not found! [$DB_FILENAME]"
    exit 1
fi

echo "--> Cleaning up directus database [$DB_FILENAME]..."

# Reset some tables
echo "... resetting tables: activity, revisions, sessions, users"
sqlite3 "$DB_FILENAME" "DELETE FROM directus_activity"
sqlite3 "$DB_FILENAME" "DELETE FROM directus_revisions"
sqlite3 "$DB_FILENAME" "DELETE FROM directus_sessions"
sqlite3 "$DB_FILENAME" "DELETE FROM directus_users WHERE email <> 'setup@example.com'"

# Update user ids
echo "... updating user ids to the initial setup user"
uid=$(sqlite3 "$DB_FILENAME" "SELECT id FROM directus_users WHERE email = 'setup@example.com'")
now=$(date '+%s000')
sqlite3 "$DB_FILENAME" "UPDATE alert SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
sqlite3 "$DB_FILENAME" "UPDATE details SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
sqlite3 "$DB_FILENAME" "UPDATE featured_pages SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
sqlite3 "$DB_FILENAME" "UPDATE guests SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
sqlite3 "$DB_FILENAME" "UPDATE invitations SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
sqlite3 "$DB_FILENAME" "UPDATE meal_choices SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
sqlite3 "$DB_FILENAME" "UPDATE pages SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
sqlite3 "$DB_FILENAME" "UPDATE photos SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
sqlite3 "$DB_FILENAME" "UPDATE recommendation_links SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
sqlite3 "$DB_FILENAME" "UPDATE recommendations SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
sqlite3 "$DB_FILENAME" "UPDATE schedule_items SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
sqlite3 "$DB_FILENAME" "UPDATE tables SET user_created = '$uid', user_updated = '$uid', date_updated = '$now'"
