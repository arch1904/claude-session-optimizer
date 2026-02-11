#!/bin/bash
# Quick health check for Claude session refresh

# Check cron
CRON_ENTRY=$(crontab -l 2>/dev/null | grep "session_refresh")
if [ -n "$CRON_ENTRY" ]; then
    echo "Cron: installed"
    echo "  $CRON_ENTRY"
else
    echo "Cron: not installed"
fi

# Show recent log
LOG_FILE="$HOME/claude_session_refresh.log"
if [ -f "$LOG_FILE" ]; then
    echo ""
    echo "Last 3 runs:"
    grep -E "^\[" "$LOG_FILE" | tail -6
else
    echo "No log file found."
fi
