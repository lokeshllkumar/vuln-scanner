#!/bin/bash

TARGET=$1
REPORT=$2

log "Running Nmap scan on $TARGET..."

nmap -p 80,443 -sV --script=banner --open "$TARGET" -oG - | while read -r line; do
    if [[$line == *"open"*]]; then
        PORT=$(echo "$line" | awk '{print $2}')
        BANNER=$(echo "$line" | awk '{print substr($0, index($0,$5))}')

        # matching common CVE patterns
        if [[ $BANNER =~ CVE-[0-9]{4}-[0-9]{4,} ]]; then
            log "WARNING" "Potential CVE detected on $TARGET: $BANNER"
            STATUS="CRITICAL"
        else
            STATUS="SAFE"
        fi

        jq --arg target "$TARGET" --arg port "$PORT" --arg banner "$BANNER" --arg status "$STATUS" \
            '.targets += [{ "host": $target, "port": $port, "banner": $banner, "status": $status }]' "$REPORT" > tmp.json && mv tmp.json "$REPORT"
    fi
done