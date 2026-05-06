# Starter Pack — Pipeline éditorial blog tech

Outillage Claude Code pour un pipeline éditorial `idea → knowledge → output` (articles, posts LinkedIn, REX, talks) en français.

## Structure

```
CLAUDE.md                          # Instructions principales : pipeline, phases, templates, règles de promotion
.claude/
  style-guide.md                   # Référence stylistique : patterns à conserver, formules à bannir, règles journaliste
  settings.local.json              # Permissions Claude Code pré-accordées (git, gh, web, Slack…)
  agents/
    redacteur.md                   # Agent d'aide à l'écriture sur les outputs — reformulation, hook, comptage caractères
    reviewer.md                    # Agent de review multi-angles (journaliste / anti-putaclic / bullshit detector)
  commands/
    review-idea.md                 # Skill /review-idea  — audit qualité d'un fichier ideas/ (prose, champs, blocs pré-orientants)
    review-knowledge.md            # Skill /review-knowledge — audit sourçage et dérive article d'un fichier knowledge/
    review-voice.md                # Skill /review-voice — audit voix d'un output (patterns bannis, règles journaliste)
```

## Usage

- Copier ce répertoire à la racine d'un projet éditorial
- Créer les dossiers `ideas/`, `knowledge/`, `outputs/`, `templates/`
- Adapter `settings.local.json` aux permissions nécessaires
- Les agents et skills s'appuient sur `style-guide.md` — le personnaliser en priorité
