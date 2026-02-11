#!/bin/bash
# Installs the cron job for 6 AM daily

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_PATH="$SCRIPT_DIR/session_refresh.sh"

chmod +x "$SCRIPT_PATH"

# Add cron entry (6 AM daily), preserving existing crontab
(crontab -l 2>/dev/null | grep -v "session_refresh"; echo "0 6 * * * $SCRIPT_PATH") | crontab -

echo "Cron job installed. Verify with: crontab -l"
