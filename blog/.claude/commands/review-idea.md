Audit qualité d'un fichier `ideas/` du pipeline éditorial.

## Instructions

1. Si un chemin de fichier `ideas/` est fourni, lis son contenu complet. Si le fichier n'existe pas, le signaler et arrêter. Si aucun fichier n'est mentionné, demande lequel auditer.

2. Lis `templates/idea.md` pour référence des champs attendus.

3. Produis un rapport structuré :

### Violations prose
Signale chaque phrase complète ou paragraphe rédigé. Format pour chaque violation :
1. Ligne approximative : [citation courte] → type de violation

Types de violations :
- **Phrase complète** : sujet + verbe + complément développé (doit être un bullet point ou un label court)
- **Paragraphe narratif** : plusieurs phrases enchaînées avec logique argumentative
- **Verbe conjugué développé** : "cela montre que...", "on peut voir que..." — nommer l'observation suffit

### Blocs pré-orientants
Signale les blocs qui risquent de contaminer les outputs ultérieurs :
- Structure trop narrative (ressemble déjà à un plan d'article)
- Angle trop affirmé (déjà une conclusion formulée)
- Formulation qui ressemble à un hook rédigé
- Transition entre idées déjà écrite en prose

Format : - [citation courte] → risque identifié

### Champs manquants
Compare avec `templates/idea.md`. Signale les champs absents ou vides :
- **Statut** : présent / absent
- **Tension** (obligatoire — sans tension, l'idée n'est pas cadrable) : présente / absente
- **Format** (famille + type + cible) : présent / absent

## Contraintes
- Ne corrige pas automatiquement
- Produis une liste numérotée de violations pour décision manuelle
- Les bullet points, mots-clés, labels courts, fragments nominaux sont conformes — ne les signale pas
- Un fichier sans violation est un bon résultat : le dire explicitement
