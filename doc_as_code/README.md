# Starter Pack — DAT as Code

Outillage Claude Code pour générer et synchroniser une Documentation d'Architecture Technique (DAT) depuis le code source (Terraform, IaC).

**Concept** : templates Markdown avec instructions embarquées + MCPs connecteurs (GitHub, Atlassian, context7) + framework Diataxis.

Issu du retex [DAT as Code : automatiser la documentation technique avec l'IA](https://github.com/agaches/ia_field/tree/main/dat_as_code_with_ia).

## Ce que ça fait

- Analyse le code Terraform/IaC via MCP GitHub
- Génère la doc par itération (README, IAM, FW, SIZING, DEX, procédures)
- Publie sur Confluence avec GitHub comme source de vérité
- Trace les écarts via Jira

## Structure

```
CLAUDE.md                      # Instructions Claude Code : persona, workflow, règles Confluence/Jira
README.md                      # Ce fichier
tpl_docs/
  TPL_README.md                # Vue globale infrastructure
  TPL_README_IAM.md            # IAM et permissions
  TPL_README_FW.md             # Réseau et firewall
  TPL_README_SIZING.md         # Dimensionnement des ressources
  TPL_README_DEX.md            # Dossier d'exploitation
  TPL_README_PROCEDURE.md      # Procédures opérationnelles (1 par composant)
.claude/
  skills/
    explanation.md             # Skill Diataxis — documentation conceptuelle
    howto.md                   # Skill Diataxis — procédures orientées objectif
    reference.md               # Skill Diataxis — référence technique factuelle
    tutorial.md                # Skill Diataxis — guide d'apprentissage
  settings.local.json          # Permissions Claude Code pré-accordées
```

## Prérequis

MCPs à installer dans l'IDE :

| MCP | Installer |
|-----|-----------|
| github | `npx @modelcontextprotocol/server-github` |
| Atlassian | `npx @modelcontextprotocol/server-atlassian` |
| context7 | `npx @context7/mcp-server` |

## Usage

1. Copier ce répertoire à la racine du projet à documenter
2. Remplir la section **Contexte projet** dans `CLAUDE.md` (repo, URLs Confluence/Jira)
3. Copier les templates `tpl_docs/` dans le projet (ou les laisser ici et pointer dessus)
4. Ouvrir Claude Code dans le projet
5. Claude suit le workflow : inputs → plan → génération itérative → sync Confluence

## Récupérer les identifiants Atlassian

**Confluence** — depuis l'URL `https://domaine.atlassian.net/wiki/spaces/**SPACE_KEY**/pages/**PAGE_ID**/Titre`

**Jira** — depuis l'URL `https://domaine.atlassian.net/jira/software/c/projects/**PROJECT_KEY**/boards/**BOARD_ID**`

## Bilan terrain (retex)

- Config (MCPs + settings) : ~1h
- Génération doc complète : ~1h
- Résultat : README archi + IAM + firewall + DEX + procédures + page Confluence

**Limite** : toujours relire. L'IA peut approximer des chiffres ou halluciner des détails techniques. L'outil supprime la page blanche, pas la relecture.
