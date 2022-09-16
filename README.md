# Thème sombre avec du noir RGB(0,0,0) pour l'extension "Github theme" de VSCode

Pour ajouter un des thèmes ci-dessus il suffit d'aller dans le répertoire suivant :

```shell
C:\Users\[votre_nom_dutilisateur]\.vscode\extensions\github.github-vscode-theme-6.3.2
```
  
Ouvrez le fichier qui se nomme ``` package.json ``` puis ajouter le texte qui suit dans le fichier en remplaçant le ```X``` par le numero du thème que vous avez choisi.

```json
{
    "label": "GitHub Dark Perso X",
    "uiTheme": "vs-dark",
    "path": "./themes/dark-perso-X.json"
}
```
  

Voici un exemple de comment modifier le fichier ``` package.json ``` afin que l'extension aie connaissance du ou des nouveaux thèmes
![alt image du fichier package.json](https://github.com/FloRobart/Themes_for_vsCode/blob/main/github_package_modif.png?raw=true)

Une fois que c'est fait, il faut ajouter le ou les fichiers thèmes qui contiennent toutes les informations des différents éléments de VSCode.  
Pour cela, télécharger l'un des thèmes ci-dessus puis placer les dans le dossier.

```shell
C:\Users\[votre_nom_dutilisateur]\.vscode\extensions\github.github-vscode-theme-6.3.2/themes
```
  

Maintenant lancer ou relancer VSCode puis aller dans les paramètres de l'extension "Github theme" puis sélectionnez le thème que vous désirez.


PS : le thème le plus abouti et compatible avec GitHub Copilot est le thème ```Dark perso 3```
