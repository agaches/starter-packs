#!/bin/sh
# Test de bin/claude-agent-run. Un faux claude affiche ses arguments : rien n'est envoyé à l'API.
# Usage : sh tests/test-claude-agent-run.sh   (depuis le dossier du pack)
set -u
RUN="$(cd "$(dirname "$0")/.." && pwd)/bin/claude-agent-run"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
printf '#!/bin/sh\necho "$*"\nenv | grep -E "^(CLAUDE_CONFIG_DIR|CLAUDECODE|ANTHROPIC_BASE_URL)=" || true\n' > "$T/claude"
chmod +x "$T/claude"
export CLAUDE_AGENT_CLAUDE="$T/claude"
unset CLAUDE_AGENT_PLUGIN CLAUDE_AGENT_DEFAULT CLAUDE_AGENT_CONFIG_DIR CLAUDE_AGENT_SETTINGS
ok=0; ko=0
has()  { if printf '%s' "$2" | grep -qF -- "$3"; then ok=$((ok+1)); else ko=$((ko+1)); echo "ÉCHEC $1 : attendu « $3 » dans « $2 »"; fi; }
hasnt(){ if printf '%s' "$2" | grep -qF -- "$3"; then ko=$((ko+1)); echo "ÉCHEC $1 : « $3 » inattendu dans « $2 »"; else ok=$((ok+1)); fi; }

has   p_force        "$(sh "$RUN" "x")"                                  "-p x"
hasnt sans_agent     "$(sh "$RUN" "x")"                                  "--agent"
has   agent_simple   "$(sh "$RUN" --agent=analyst "x")"                  "--agent analyst"
has   agent_plugin   "$(CLAUDE_AGENT_PLUGIN=kit sh "$RUN" --agent tester "x")" "--agent kit:tester"
has   agent_complet  "$(CLAUDE_AGENT_PLUGIN=kit sh "$RUN" --agent=autre:qa "x")" "--agent autre:qa"
has   agent_defaut   "$(CLAUDE_AGENT_PLUGIN=kit CLAUDE_AGENT_DEFAULT=dev sh "$RUN" "x")" "--agent kit:dev"
hasnt agent_none     "$(CLAUDE_AGENT_DEFAULT=dev sh "$RUN" --agent=none "x")" "--agent"
has   effort         "$(sh "$RUN" --thinking=high "x")"                  "--effort high"
has   thinking_natif "$(sh "$RUN" --thinking adaptive "x")"              "--thinking adaptive"
has   model          "$(sh "$RUN" --model sonnet "x")"                   "--model sonnet"
has   settings       "$(CLAUDE_AGENT_SETTINGS=/tmp/s.json sh "$RUN" "x")" "--settings /tmp/s.json"
has   config_dir     "$(CLAUDE_AGENT_CONFIG_DIR=/tmp/cfg sh "$RUN" "x")" "CLAUDE_CONFIG_DIR=/tmp/cfg"
hasnt herite_parent  "$(CLAUDECODE=1 ANTHROPIC_BASE_URL=http://x sh "$RUN" "x")" "CLAUDECODE="
out=$(sh "$RUN" --thinking=extreme "x" 2>&1); rc=$?
if [ $rc -eq 2 ]; then ok=$((ok+1)); else ko=$((ko+1)); echo "ÉCHEC thinking_invalide : rc=$rc « $out »"; fi

echo "OK=$ok ÉCHECS=$ko"; [ $ko -eq 0 ]
