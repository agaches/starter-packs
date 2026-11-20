#!/bin/sh
# apiKeyHelper de Claude Code : renvoie la clé API sur stdout, lue dans un fichier hors dépôt.
# Fichier : $CLAUDE_AGENT_KEY_FILE, défaut ~/.config/anthropic/agents.key, droits 600 ou 400 exigés.
# La clé n'est jamais exportée en variable d'environnement : une session interactive sur abonnement
# lancée dans le même shell la prendrait à la place de l'abonnement.
f="${CLAUDE_AGENT_KEY_FILE:-$HOME/.config/anthropic/agents.key}"
[ -s "$f" ] || { echo "api-key-helper : clé absente, remplir $f (chmod 600)" >&2; exit 1; }
case "$(stat -c %a "$f" 2>/dev/null || stat -f %Lp "$f")" in
  600|400) ;;
  *) echo "api-key-helper : $f doit être en 600" >&2; exit 1 ;;
esac
tr -d '[:space:]' < "$f"
