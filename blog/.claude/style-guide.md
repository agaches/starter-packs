# Style guide éditorial

Conventions de ton, patterns à conserver, formules à bannir, règles de journaliste.
Référencé par les agents `redacteur` et `reviewer`, et le skill `/review-voice`.

---

## Conventions générales

- **Langue** : français, pas d'accents dans les noms de fichiers (slugs ASCII)
- **Ton** : praticien expérimenté qui partage — pas un communiqué de presse, pas un tutoriel. Voix "retour d'expérience" à la première personne.
- **Audience** : devs, tech leads, architectes, DSI
- **Structure** : hook (personnel/provocateur) → exemples concrets → nuance → question CTA
- **Métadonnées éditoriales** : comptages de caractères, variantes de hook, matière coupée — à préserver lors des éditions

---

## Patterns à conserver

- **Phrase isolée pour l'impact** : "Sauf que." "Fail." "L'itératif, c'est le bien." — une idée seule sur sa ligne, pas besoin de l'habiller.
- **Chiffres concrets et temporels** : "45 minutes", "30 secondes", "2h de setup" — les durées et mesures ancrent le propos.
- **Notation `→`** pour les heuristiques binaires et les étapes : "Déterministe, répétable → CLI. Exploratoire, mal structuré → MCP."
- **Reprendre une citation et creuser dedans** : citer un collègue, puis reformuler ce que ça implique concrètement.
- **CTA en vraie question ouverte** : "Et vous, vos commandes git, de mémoire ou avec filet ?" — invite à la conversation, pas à la validation.
- **Bold parcimonieux** : uniquement sur les concepts clés, jamais pour décorer.

---

## Transitions et formules à bannir

Ces patterns sonnent IA, sont prétentieux ou mécaniques — ne pas les utiliser :

| Pattern | Pourquoi le bannir |
|---|---|
| "Le vrai..." / "La vraie..." | Overused — "Le vrai gain", "La vraie question", "Le vrai problème" — signal trop appuyé |
| "Dit autrement :" | Condescendant — si la phrase précédente était claire, la reformulation est inutile |
| "C'est exactement ce qui/ça/le piège" | Intensifieur formulaique, typique de l'écriture IA |
| "Et c'est peut-être le point le plus important." | Théâtral, signale l'importance au lieu de la montrer |
| "Et c'est normal." | Paternaliste pour clore un paragraphe |
| "Voici pourquoi." en fin de hook | Pattern clickbait |
| "Premier exemple / Deuxième exemple / Troisième exemple" | Structure mécanique et scolaire |
| "X ne disparaît pas. Elle change de nature." | Conclusion antithétique trop lissée, trop propre |
| "Ce n'est pas qu'une question de X. C'est une question de Y." | Cliché de transition |
| "C'est là que..." comme pivot dramatique | Artificiel |
| "Ce qui m'a frappé" / "Ce qui m'a retenu" / "C'est le point qui..." | Nommer l'émotion au lieu de la provoquer — si c'est frappant, écris-le de façon à ce que ça frappe |
| "C'est le signal." en chute de paragraphe | Conclure à la place du lecteur |

---

## Règles de journaliste

**Montre, ne dis pas.**
Ne pas nommer l'émotion ou l'importance — les faire ressentir. "L'anecdote qui m'a bluffé" → supprime la phrase, raconte l'anecdote, laisse le lecteur être bluffé.

**Le gras est une ressource rare.**
Un seul passage en gras par article, maximum. Et seulement si la phrase est déjà forte sans lui. Le gras amplifie, il ne sauve pas une phrase faible.

**La chute ne se pose pas, elle arrive.**
Ne pas écrire le CTA avant d'avoir fini le corps. La question finale doit émerger de ce qui précède — si tu dois la chercher, c'est que le corps n'a pas trouvé sa conclusion naturelle.

**Préserver les imperfections de voix.**
Lors d'une reformulation, conserver : les parenthèses informelles, l'auto-dérision, les phrases qui respirent, le mot familier au milieu d'une phrase technique. Ces aspérités signalent qu'il y a un auteur derrière.

**Test de la suppression du premier paragraphe.**
Après rédaction : supprimer mentalement la première phrase. Si le texte tient sans elle, elle n'était pas le vrai début. L'article démarre souvent au deuxième paragraphe.

**Un seul registre par article.**
Choisir : raconter ou instruire. Pas les deux. Un REX est un récit — pas une liste de leçons. Un guide est une liste ordonnée — pas une anecdote. Mélanger produit un texte qui ne sait pas ce qu'il veut.

**Trois relectures ciblées après génération.**
1. **Voix** — chaque phrase sonne-t-elle comme l'auteur ou comme "du bon texte générique" ?
2. **Redondance** — la même idée est-elle dite deux fois sous des formes différentes ?
3. **Chute** — la dernière phrase justifie-t-elle qu'on ait lu tout ce qui précède ?

---

## Transitions qui fonctionnent (extraites des articles)

- Rupture sèche : "Sauf que." seul, puis la phrase qui renverse.
- Deux colonnes sans intro : "Déterministe → CLI. Exploratoire → MCP." — le lecteur comprend sans explication.
- Reprise d'une citation par sa conséquence : citer, puis "Mais 'X' est la clé de la phrase."
- Conclusion par une limite concrète, pas par une morale : "Un MCP que personne ne sait déboguer, c'est pire qu'une CLI rustique bien maîtrisée."
