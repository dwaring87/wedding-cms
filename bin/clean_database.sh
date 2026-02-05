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

echo "--> Removing unneccessary data from directus tables [$DB_FILENAME]..."
sqlite3 "$DB_FILENAME" "DELETE FROM directus_activity"
sqlite3 "$DB_FILENAME" "DELETE FROM directus_revisions"
sqlite3 "$DB_FILENAME" "DELETE FROM directus_sessions"
sqlite3 "$DB_FILENAME" "DELETE FROM directus_users WHERE email <> 'setup@example.com'"