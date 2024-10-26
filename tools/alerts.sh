#!/bin/bash

source config/slack.conf

REPORT=$1

CRITICAL=${jq '.targets[] | select(.status == " CRITICAL")' "$REPORT"}

if [ -n "$CRITICAL" ]; then
    log "ALERT" "Critical vulnerabilities detected"

    echo "Critical issues found: $CRITICAL"

    curl -X POST -H 'Content-type: application/json' \
        --data '{"text": "Critical vulnerabilites found:\n'"$CRITICAL"'"}' \
        "$SLACK_WEBHOOK_URL"
fi