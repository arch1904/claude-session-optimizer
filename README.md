# Claude Session Optimizer

Automatically starts a Claude CLI session at a set time each day so your usage limit window aligns with your work hours instead of resetting at inconvenient times.

Designed to run on an always-on machine (e.g., a homeserver) via cron.

## How it works

A cron job runs `claude -p "hello"` at your chosen time daily. This starts a new session, anchoring the limit reset window to that time. The interaction is non-interactive and logs output for debugging.

## Setup

```bash
git clone <repo-url> && cd claude_session_optimizer

# Install with default time (6:00 AM)
./install.sh

# Or specify a time in military format (HHMM)
./install.sh 0700    # 7:00 AM
./install.sh 1430    # 2:30 PM
```

## Verify

```bash
# Check the cron entry
crontab -l

# Run manually to test
./session_refresh.sh

# Check the log
cat ~/claude_session_refresh.log
```

## Files

| File | Purpose |
|---|---|
| `session_refresh.sh` | Sends a single message to Claude CLI and logs the result (60s timeout, auto-rotates log) |
| `install.sh` | Sets up (or updates) the daily cron job |
| `status.sh` | Shows cron status and recent log entries |
| `uninstall.sh` | Removes the cron job (use `--clean` to also delete the log file) |

## Status

```bash
./status.sh
```

## Uninstall

```bash
# Remove cron job only
./uninstall.sh

# Remove cron job and delete log file
./uninstall.sh --clean
```
