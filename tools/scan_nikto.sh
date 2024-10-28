#!/bin/bash

TARGET=$1
REPORT=$2

log "INFO" "Running Nikto scan on web target..."

nikto -host "$TARGET" -output /dev/null | grep -E "OSVDB|CVE" | while read -r vuln; do
    jq --arg target "$TARGET" --arg vuln "$vuln" \
        '.targets += [{ "host": $target, "vulnerability": $vuln }]' "$REPORT" > tmp.json && mv tmp.json "$REPORT"
done