#!/usr/bin/env bash
# Read JSON data that Claude Code sends to stdin
input=$(cat)

# Extract fields
model=$(echo "$input" | jq -r '.model.display_name')
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
has_rate_limits=$(echo "$input" | jq -r 'if .rate_limits then "true" else "false" end')

# Build status line
status="$model | ${ctx_pct}%"

if [ "$has_rate_limits" = "true" ]; then
  rl_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0' | cut -d. -f1)
  rl_resets_ts=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
  if [ -n "$rl_resets_ts" ]; then
    rl_resets=$(date -r "$rl_resets_ts" +"%H:%M" 2>/dev/null || date -d "@$rl_resets_ts" +"%H:%M")
    status="$status | ${rl_pct}% 5h (resets ${rl_resets})"
  else
    status="$status | ${rl_pct}% 5h"
  fi
fi

# Show cost only when on API (no rate limits, or 5h window exhausted)
if [ "$has_rate_limits" = "false" ] || [ "$rl_pct" -ge 100 ] 2>/dev/null; then
  cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
  if [ "$(echo "$cost > 0" | bc -l)" = "1" ]; then
    cost_fmt=$(echo "$input" | jq -r '.cost.total_cost_usd * 10000 | round / 10000 | tostring')
    status="$status | \$$cost_fmt"
  fi
fi

echo "$status"
