# Starter Pack — Claude Code Statusline

Statusline personnalisée pour Claude Code : affiche utilisateur, répertoire, modèle, contexte et quotas d'utilisation en temps réel.

**Résultat :**
```
a.gaches ~/workspace/git/monrepo Claude Sonnet 4.6 (normal) | ctx: 42% [84k tkns] | 5h: 15% 7d: 30%
```

## Ce que ça affiche

| Élément | Couleur | Source JSON |
|---|---|---|
| Utilisateur | Cyan | `whoami` |
| Répertoire courant (`~` substitué) | Jaune | `.workspace.current_dir` |
| Modèle actif | Magenta | `.model.display_name` |
| Niveau d'effort | Cyan | `.effort.level` |
| `[thinking]` si actif | Bleu | `.thinking.enabled` |
| Contexte utilisé (%) + tokens | Vert/Jaune/Rouge | `.context_window.*` |
| Fenêtre 5h (%) | Cyan/Bleu/Magenta | `.rate_limits.five_hour.used_percentage` |
| Fenêtre 7j (%) | Cyan/Bleu/Magenta | `.rate_limits.seven_day.used_percentage` |

**Seuils couleur contexte :** vert < 50 % · jaune 50–80 % · rouge > 80 %  
**Seuils couleur quotas :** cyan < 50 % · bleu 50–80 % · magenta > 80 %

**Non disponible via statusline :** consommation monétaire (EUR), quota Sonnet mensuel — voir `console.anthropic.com`.

## Prérequis

- Claude Code ≥ 1.x avec support `statusCommand`
- `jq` installé (`brew install jq` sur macOS)

## Installation

**1. Copier le script**

```bash
cp statusline-command.sh ~/.claude/statusline-command.sh
chmod +x ~/.claude/statusline-command.sh
```

**2. Déclarer dans `~/.claude/settings.json`**

```json
{
  "statusCommand": "$HOME/.claude/statusline-command.sh"
}
```

**3. Tester sans relancer Claude Code**

```bash
echo '{
  "model": {"display_name": "Claude Sonnet 4.6"},
  "workspace": {"current_dir": "$HOME/monrepo"},
  "effort": {"level": "normal"},
  "thinking": {"enabled": false},
  "context_window": {"used_percentage": 42, "context_window_size": 200000},
  "rate_limits": {
    "five_hour": {"used_percentage": 15},
    "seven_day":  {"used_percentage": 30}
  }
}' | ~/.claude/statusline-command.sh
```

## Personnaliser

### Ajouter un champ JSON

```bash
# 1. Extraire le champ en haut du script
model_id=$(echo "$input" | jq -r '.model.id // ""')

# 2. L'injecter dans la variable parts
if [ -n "$model_id" ]; then
  parts+=$(printf " ${CYAN}%s${RESET}" "$model_id")
fi
```

### Changer les couleurs

```
\033[0;31m  Rouge
\033[0;32m  Vert
\033[0;33m  Jaune
\033[0;34m  Bleu
\033[0;35m  Magenta
\033[0;36m  Cyan
\033[0m     Reset
```

### Champs JSON disponibles (référence complète)

```
.workspace.current_dir
.model.display_name
.model.id
.effort.level
.thinking.enabled
.context_window.used_percentage
.context_window.context_window_size
.rate_limits.five_hour.used_percentage
.rate_limits.five_hour.resets_at
.rate_limits.seven_day.used_percentage
.rate_limits.seven_day.resets_at
```

> Les champs `.rate_limits.*` ne sont disponibles qu'après le premier appel API de la session et uniquement pour les abonnés Claude.ai (pas avec une clé API).
