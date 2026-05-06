Audit qualité d'un fichier `knowledge/` du pipeline éditorial.

## Instructions

1. Si un chemin de fichier `knowledge/` est fourni, lis son contenu complet. Si le fichier n'existe pas, le signaler et arrêter. Si aucun fichier n'est mentionné, demande lequel auditer.

2. Lis `templates/knowledge.md` pour référence du format attendu.

3. Produis un rapport structuré :

### Dérive article
Signale les sections qui ressemblent à un draft d'article plutôt qu'à de la donnée sourcée :
- Prose narrative avec connecteurs logiques ("ensuite", "ainsi", "c'est pourquoi", "on peut donc")
- Paragraphes qui concluent ou argumentent au lieu de stocker un fait
- Transitions rédigées entre blocs (le knowledge est une structure de données, pas un texte)

Format : `Section [nom] — [type de dérive] — [citation courte]`

### Sourçage manquant
Signale chaque paragraphe (délimité par une ligne vide) de 3 lignes ou plus sans tag `[source: user]`, `[source: ia]` ou `[source: @ref]`.
Format : `[citation courte] → tag recommandé selon contexte`

### Affirmations non ancrées
Signale les généralisations ou affirmations importantes sans base factuelle visible dans le fichier :
- "Les entreprises font X" sans exemple ni source
- Chiffres ou dates sans `[source: @ref]`
- Tendances affirmées sans observation concrète

Format : `[citation courte] → ancrage manquant`

### Champs manquants
- **Origine** (référence vers `ideas/`) : présente / absente
- **Statut** (`en cours` ou `complete`) : présent / absent

## Contraintes
- Ne réécrit pas les sections
- Signale uniquement — la correction reste à l'auteur
- La prose intégralement sourcée (chaque bloc taggé) n'est pas une violation — ne pas la signaler
- Exception : une prose sourcée mais argumentative (qui conclut au lieu de stocker) peut être signalée en Dérive article — les deux checks sont indépendants
- Un fichier sans violation est un bon résultat : écrire "Aucune violation détectée — fichier conforme." et arrêter le rapport
