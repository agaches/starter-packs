# claude-agents-separes

Lancer des agents Claude Code en **processus séparés** depuis une session pilote : un modèle, un effort et un compte par agent.

## Pourquoi

- Les sous-agents de l'outil Agent tournent **dans** la session du pilote : même compte, même facturation, même quota.
- Un agent en processus séparé (`claude -p`) a sa propre session :
  - son modèle (`--model opus|sonnet|haiku`) et son effort (`--effort`) ;
  - son compte : abonnement (compte connecté) ou clé API, indépendamment du pilote ;
  - sa sortie structurée (`--output-format json --json-schema`), lue par le pilote à la fin du processus ;
  - son worktree git (`-w <nom>`) et son plafond de dépense (`--max-budget-usd`).
- Cas d'usage : pilote interactif sur abonnement, exécutants sur clé API ; ou tout sur abonnement ; ou tout sur clé API.

## Contenu

| Fichier | Rôle |
|---|---|
| `bin/claude-agent-run` | Lanceur : `-p` forcé, `--agent` / `--thinking`, nettoyage de l'environnement hérité du pilote, compte choisi par variables |
| `api/api-key-helper.sh` | `apiKeyHelper` : lit la clé dans un fichier en 600, jamais dans l'environnement |
| `api/api-settings.example.json` | Settings qui branchent le helper |
| `tests/test-claude-agent-run.sh` | Tests du lanceur avec un faux `claude` (aucun appel API) |

## Prérequis

- Claude Code ≥ 2.1.329 (options `--agent`, `--effort`, `--json-schema`, `--max-budget-usd`, `-w`)
- POSIX sh, `git`
- Pour le mode clé API : une clé Anthropic (console) dans un fichier

## Installation

```sh
install -m 755 bin/claude-agent-run ~/.local/bin/
sh tests/test-claude-agent-run.sh        # attendu : OK=14 ÉCHECS=0
```

### Mode abonnement

- Rien à configurer : l'agent utilise le compte connecté (`claude login`).
- Vérifier : `claude-agent-run --model haiku "Réponds OK"`

### Mode clé API

```sh
mkdir -p ~/.claude-agents ~/.config/anthropic
install -m 700 api/api-key-helper.sh ~/.claude-agents/
cp api/api-settings.example.json ~/.claude-agents/api-settings.json
( umask 077; $EDITOR ~/.config/anthropic/agents.key )   # coller la clé, droits 600
```

À exporter dans le shell du pilote (ou dans un wrapper) :

```sh
export CLAUDE_AGENT_CONFIG_DIR=~/.claude-agents        # config dir séparé : pas de login OAuth dedans
export CLAUDE_AGENT_SETTINGS=~/.claude-agents/api-settings.json
```

- Config dir séparé : sans login OAuth, la clé du helper est la seule authentification possible.
- Optionnel : lier `settings.json`, `CLAUDE.md`, `skills`, `agents`, `plugins` du config dir principal pour partager la config.
- Vérifier : `claude-agent-run --model haiku --output-format json "Réponds OK"` → `apiKeySource` = `apiKeyHelper`.

### Variables

| Variable | Défaut | Effet |
|---|---|---|
| `CLAUDE_AGENT_CLAUDE` | `claude` | Binaire appelé (ex. shim d'une passerelle LLM pour les stats) |
| `CLAUDE_AGENT_CONFIG_DIR` | celui du pilote | Config dir de l'agent |
| `CLAUDE_AGENT_SETTINGS` | — | Fichier `--settings` (helper de clé) |
| `CLAUDE_AGENT_PLUGIN` | — | Préfixe des agents : `--agent=dev` → `--agent <plugin>:dev` |
| `CLAUDE_AGENT_DEFAULT` | aucun | Agent utilisé sans `--agent` |
| `CLAUDE_AGENT_KEY_FILE` | `~/.config/anthropic/agents.key` | Fichier de clé lu par le helper |

## Utilisation

```sh
claude-agent-run --agent=analyst --model opus   --thinking=high   "Écris docs/specs/ d'après docs/besoin.md"
claude-agent-run --agent=dev     --model sonnet --thinking=medium -w ACT-003 "Fais ACT-003 de docs/plan.md"
claude-agent-run --model haiku "…"                                 # sans agent
```

- `--thinking=low|medium|high|xhigh|max` → `--effort` ; `enabled|adaptive|disabled` → `--thinking` natif.
- `--agent=none` : aucun agent, même si `CLAUDE_AGENT_DEFAULT` est défini.
- Toute autre option est transmise à `claude`.

### Depuis le pilote

- Lancer par l'outil Bash, **en arrière-plan** : le pilote est réveillé à la fin du processus.
- Une tâche = un processus ; ne passer que des pointeurs (chemins, identifiants), pas le contenu.
- Résultat structuré, par exemple :

```sh
claude-agent-run --agent=dev --model sonnet --max-budget-usd 2 \
  --output-format json --json-schema "$(cat schemas/agent-result.schema.json)" \
  --permission-mode acceptEdits --allowedTools "Bash(git:*)" "Bash(npm test:*)" \
  -w ACT-003 "Fais ACT-003 de docs/plan.md"
```

- Le pilote lit `structured_output` (statut, fichiers, blocage). Pas de JSON ou code ≠ 0 ⇒ échec, avec la fin de la sortie.

## Points d'attention

- **Coût de démarrage** : chaque processus recharge son contexte (prompt système, outils, `CLAUDE.md`), ~30 k tokens. Préférer Sonnet ou Haiku pour les exécutants.
- **Mode `-p` obligatoire pour les agents** : le lanceur l'ajoute. Une organisation peut accepter l'usage sans interface de sa clé API et refuser l'usage interactif de Claude Code (erreur trompeuse « credit balance is too low ») : tester les deux avant de construire dessus, et respecter le choix de l'organisation.
- **Clé API jamais exportée** : un `ANTHROPIC_API_KEY` dans l'environnement prend le pas sur l'abonnement de toute session lancée depuis ce shell.
- **Environnement du pilote** : le lanceur retire les variables de session héritées (`CLAUDECODE`, `CLAUDE_CODE_*`, `ANTHROPIC_BASE_URL`, en-têtes) ; une passerelle se configure via `CLAUDE_AGENT_CLAUDE`, pas par héritage.
- **Permissions** : en local, `acceptEdits` + liste blanche ; `bypassPermissions` seulement dans un conteneur jetable.
- **Chemins** : `CLAUDE_AGENT_CONFIG_DIR` sans espace.

## Personnaliser

- Wrapper personnel : fixer les variables puis `exec claude-agent-run "$@"` (ex. un `claude-api-run` qui force le mode clé API).
- Passerelle LLM (stats, compression) : pointer `CLAUDE_AGENT_CLAUDE` vers son shim.
- Plugin d'agents : `CLAUDE_AGENT_PLUGIN=<plugin>` et `CLAUDE_AGENT_DEFAULT=<agent>` pour `--agent=<nom>` court.
