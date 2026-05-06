Audit de voix sur un output du pipeline éditorial.

## Instructions

1. Si un chemin de fichier est fourni, lis son contenu complet avant d'analyser. Si aucun texte n'est fourni dans le message, lis le fichier dans `outputs/` mentionné (ex: `outputs/mon-article.md`) ou demande lequel auditer.

2. Lis `.claude/style-guide.md` avant d'analyser — il contient le tableau complet "Transitions et formules à bannir", les "Règles de journaliste" et les "Patterns à conserver".

3. Produis un rapport structuré :

### Patterns bannis détectés
Pour chaque occurrence :
- Citation exacte du passage
- Nom du pattern violé (reprendre le libellé exact du tableau CLAUDE.md)
- Sévérité : mineur | majeur | bloquant
- Suggestion minimale — corriger ce passage uniquement, ne pas réécrire le paragraphe

### Violations des règles journaliste
Vérifie et signale :
- Phrase qui nomme l'importance ou l'émotion au lieu de laisser le contenu la provoquer (ex: "ce qui m'a frappé", "c'est le signal")
- Gras utilisé plus d'une fois dans l'article
- Premier paragraphe supprimable (le texte tient-il sans lui ?)
- Mélange de registres (récit + instruction dans le même article)
- Chute apposée plutôt qu'émergente
- Aspérités de voix signalées à tort comme défauts (parenthèses informelles, mot familier, auto-dérision, phrase courte isolée) — ce sont des marqueurs intentionnels à protéger, pas à corriger

### Passages solides
Liste des 2-3 passages qui sonnent comme l'auteur — à protéger lors des retouches futures. Cherche en priorité : phrase courte isolée pour l'impact, mesure temporelle concrète, notation →, parenthèse informelle.

### Résumé arbitrable
- Bloquants (à corriger avant publication) : N
- Majeurs (fortement recommandés) : N
- Mineurs (optionnels) : N

## Contraintes
- Ne réécris pas l'article
- Suggestions chirurgicales uniquement : corriger le passage problématique, pas le paragraphe entier
- Si tu proposes une reformulation, vérifie qu'elle n'introduit pas elle-même un pattern banni
- Sévérité des violations :
  - `bloquant` : pattern banni présent tel quel, ou violation qui casse la lisibilité de la chute ou du hook
  - `majeur` : dégradation notable de la voix, correction recommandée avant publication
  - `mineur` : bruit léger, ne change pas l'impression globale
