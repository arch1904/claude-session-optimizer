#!/bin/bash
# Removes the Claude session refresh cron job

crontab -l 2>/dev/null | grep -v "session_refresh" | crontab -
echo "Cron job removed."

if [ "$1" = "--clean" ]; then
    rm -f "$HOME/claude_session_refresh.log"
    echo "Log file deleted."
fi
