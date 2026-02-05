#! /usr/bin/env bash

UPLOADS_DIR="$1"

if [[ -z "$UPLOADS_DIR" ]]; then
	echo "ERROR: Uploads Directory not specified!"
	exit 1
fi
if [[ ! -d "$UPLOADS_DIR" ]]; then
	echo "ERROR: Uploads Directory not found! [$UPLOADS_DIR]"
	exit 1
fi

echo "--> Removing unneccessary generated assets from directus uploads [$UPLOADS_DIR]..."
files=$(find "$UPLOADS_DIR" -name "*__*")
echo "$files"
find "$UPLOADS_DIR" -name "*__*" -exec rm -- '{}' +