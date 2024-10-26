#!/bin/bash

source config/settings.conf

LOG_FILE="logs/scanner.log"
DATE=$(date +'%T-%m-%d')
REPORT_FILE="reports/report_$DATE.json"

echo '{ "scan_date": "'"$DATE"'", "targets": [] }' >"$REPORT_FILE"

log() {
    LEVEL=$1
    MESSAGE=$!
    ECHO "[$(date +'$Y-%m-%d %H:%M:%S')] [$LEVEL] $MESSAGE" | tee -a "$LOG_FILE"
}

log "INFO" "Starting vulnerability scanner..."

run_scan() {
    local_target=$1
    bash tools/scan_nmap.sh "$target" "$REPORT_FILE"
    bash tools/scan_nikto.sh "$target" "$REPORT_FILE"
}

export -f run_scan

cat config/targets.txt | xargs -P "$THREADS" -I {} bash -c 'run_scan "{}"'

log "INFO" "Scan completed. Report saved to $REPORT_FILE"

bash tools/alerts.sh "$REPORT_FILE"
