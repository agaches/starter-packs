#!/usr/bin/env bash
# Claude Code statusLine
# Format: user cwd model (tier) [thinking] | ctx: N% [Xk tkns] | 5h: N% 7d: N%

input=$(cat)

# --- extract fields ---
cwd=$(echo "$input"        | jq -r '.workspace.current_dir // .cwd // ""')
model=$(echo "$input"      | jq -r '.model.display_name // ""')
tier=$(echo "$input"       | jq -r '.effort.level // ""')
is_thinking=$(echo "$input"| jq -r '.thinking.enabled // false')
used_pct=$(echo "$input"   | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input"    | jq -r '.context_window.context_window_size // empty')
five_h=$(echo "$input"     | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_d=$(echo "$input"    | jq -r '.rate_limits.seven_day.used_percentage // empty')

# --- helpers ---
# ctx: green / yellow / red
ctx_pct_color() {
  local val; val=$(printf "%.0f" "$1")
  if   [ "$val" -gt 80 ]; then printf '\033[0;31m'
  elif [ "$val" -ge 50 ]; then printf '\033[0;33m'
  else                         printf '\033[0;32m'
  fi
}

# usage (5h/7d): cyan / blue / magenta
usage_pct_color() {
  local val; val=$(printf "%.0f" "$1")
  if   [ "$val" -gt 80 ]; then printf '\033[0;35m'   # magenta
  elif [ "$val" -ge 50 ]; then printf '\033[0;34m'   # blue
  else                         printf '\033[0;36m'   # cyan
  fi
}

RESET='\033[0m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
MAGENTA='\033[0;35m'
BLUE='\033[0;34m'

# --- 1. user (cyan) ---
user=$(whoami)
parts=$(printf "${CYAN}%s${RESET}" "$user")

# --- 2. cwd (yellow), $HOME → ~ ---
display_path="${cwd/#$HOME/~}"
parts+=$(printf " ${YELLOW}%s${RESET}" "$display_path")

# --- 3. model display name (magenta) ---
if [ -n "$model" ]; then
  parts+=$(printf " ${MAGENTA}%s${RESET}" "$model")
fi

# --- 4. tier in parentheses (cyan), omit if empty ---
if [ -n "$tier" ]; then
  parts+=$(printf " ${CYAN}(%s)${RESET}" "$tier")
fi

# --- 5. [thinking] in blue, omit if false ---
if [ "$is_thinking" = "true" ]; then
  parts+=$(printf " ${BLUE}[thinking]${RESET}")
fi

# --- 6. separator ---
parts+=" |"

# --- 7. ctx: N% [Xk tkns] ---
if [ -n "$used_pct" ]; then
  used_int=$(printf "%.0f" "$used_pct")
  ctx_color=$(ctx_pct_color "$used_pct")
  tkn_part=""
  if [ -n "$ctx_size" ] && [ "$ctx_size" -gt 0 ]; then
    tkn_count=$(( used_int * ctx_size / 100 ))
    if [ "$tkn_count" -ge 1000 ]; then
      tkn_k=$(( (tkn_count + 500) / 1000 ))
      tkn_part=" [${tkn_k}k tkns]"
    else
      tkn_part=" [${tkn_count} tkns]"
    fi
  fi
  parts+=$(printf " ${ctx_color}ctx: %d%%%s${RESET}" "$used_int" "$tkn_part")
fi

# --- 8. separator (only if rate limit data follows) ---
if [ -n "$five_h" ] || [ -n "$seven_d" ]; then
  parts+=" |"
fi

# --- 9. 5h usage ---
if [ -n "$five_h" ]; then
  five_int=$(printf "%.0f" "$five_h")
  five_color=$(usage_pct_color "$five_h")
  parts+=$(printf " ${five_color}5h: %d%%${RESET}" "$five_int")
fi

# --- 10. 7d usage ---
if [ -n "$seven_d" ]; then
  seven_int=$(printf "%.0f" "$seven_d")
  seven_color=$(usage_pct_color "$seven_d")
  parts+=$(printf " ${seven_color}7d: %d%%${RESET}" "$seven_int")
fi

printf "%b\n" "$parts"
