# Récupérer un seul fichier d'un repository GitHub

J'enregistre (je commence juste) désormais mes snippets dans un seul repository GitHub, le repository courant dans lequel vous vous baladez (et les snippets, c'est par ici https://github.com/k33g/files/tree/master/snippets) et j'aurais aimé pouvoir utiliser la commande `git archive --remote ...` pour pouvoir récupérer seulement le fichier dont j'ai besoin et non pas tous les snippets (voire tout le reste puisque mon repository "files" contient plein d'autres choses).

Hors `git archive` n'est pas supporté par GitHub, j'ai donc du me retourner vers une solution finalement plus simple: utiliser `curl`:

Si par exemple mon snippets est ici: https://github.com/k33g/files/blob/master/snippets/golo/tests/assertions.golo, pour récupérer le fichier dans un répertoire local, dans un terminal je taperais: 

    curl https://raw.githubusercontent.com/k33g/files/master/snippets/golo/tests/assertions.golo > assertions.golo

ou:

    curl -O https://raw.githubusercontent.com/k33g/files/master/snippets/golo/tests/assertions.golo
    
ou si vous souhaitez changer le nom (:warning: `o` minuscule):

    curl -o new_name.golo https://raw.githubusercontent.com/k33g/files/master/snippets/golo/tests/assertions.golo
    

Notez bien que:

- `github.com` devient `raw.githubusercontent.com`
- `files/blob/master` devient `files/master`

*Remarque*: pour downloader plusieurs fichiers: `curl -O [URL 1] [URL 2] [URL 3]`
