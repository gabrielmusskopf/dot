#!/bin/bash

DIR="$1"
if [[ -z $DIR ]]; then
    echo "find_tasks <dir>"
    exit 1
fi
TODAY=$(date +%Y-%m-%d)
EXCLUDE_DIR=""
EXCLUDE_DIR=".obsidian"

grep -r -n "(@[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\})" --exclude-dir=$EXCLUDE_DIR "$DIR" | while IFS=: read -r file line content; do
    DATE_FOUND=$(echo "$content" | grep -o "(@[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\})")
    FORMATTED_DATE=$(echo "$DATE_FOUND" | tr -d '(@)')

    TIMESTAMP_TODAY=$(date -d "$TODAY" +%s)
    TIMESTAMP_FOUND=$(date -d "$FORMATTED_DATE" +%s)

    if [[ "$TIMESTAMP_FOUND" -ge "$TIMESTAMP_TODAY" ]]; then
        echo "$content"
    fi
done
