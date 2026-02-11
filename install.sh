#!/bin/bash
# Installs the cron job for Claude session refresh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_PATH="$SCRIPT_DIR/session_refresh.sh"
TIME="${1:-0600}"

# Validate military time format (0000-2359)
if ! [[ "$TIME" =~ ^([01][0-9]|2[0-3])[0-5][0-9]$ ]]; then
    echo "Error: Invalid time '$TIME'. Use military time (0000-2359)."
    echo "Usage: ./install.sh [HHMM]"
    echo "  e.g. ./install.sh 0600   # 6:00 AM"
    echo "  e.g. ./install.sh 1430   # 2:30 PM"
    exit 1
fi

HOUR=$((10#${TIME:0:2}))
MINUTE=$((10#${TIME:2:2}))

chmod +x "$SCRIPT_PATH"

# Add cron entry, preserving existing crontab (idempotent - removes old entry first)
(crontab -l 2>/dev/null | grep -v "session_refresh"; echo "$MINUTE $HOUR * * * $SCRIPT_PATH") | crontab -

echo "Cron job installed: runs daily at $TIME."
echo "Verify with: crontab -l"
