#!/bin/bash
# Claude session refresh - runs via cron to align session limits with work hours

# Cron has minimal PATH - ensure common Claude CLI locations are included
export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:/usr/local/bin:$PATH"

LOG_FILE="$HOME/claude_session_refresh.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] Starting session refresh..." >> "$LOG_FILE"

# -p flag: sends message, waits for response, exits automatically
# --no-session-persistence: don't save session state (keeps it clean)
timeout 60s claude -p "hello" --no-session-persistence >> "$LOG_FILE" 2>&1
EXIT_CODE=$?
if [ $EXIT_CODE -eq 124 ]; then
    echo "[$TIMESTAMP] TIMEOUT after 60s" >> "$LOG_FILE"
fi
echo "[$TIMESTAMP] Done (exit code: $EXIT_CODE)" >> "$LOG_FILE"

# Rotate: keep last 200 lines
tail -n 200 "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
