##thème dark avec du vrai noir (pixel éteint) pour l'extention "Github theme" de vsCode

pour ajouter un des thèmes si dessus il suffit d'aller dans le répertoire suivant :

```shell
C:\Users\votre_nom_dutilisateur\.vscode\extensions\github.github-vscode-theme-6.3.2
```
ouvrez le fihcier qui se nomme ``` package.json ``` puis ajouter le texte qui suit dans le fichier en remplaçant le ```X``` par le numero du thèmes que vous avez choisie

```json
{
    "label": "GitHub Dark Perso X",
    "uiTheme": "vs-dark",
    "path": "./themes/dark-perso-X.json"
}
```

voici un exemple de comment modifier le fichier ``` package.json ``` 
![alt image du fichier package.json](https://github.com/FloRobart/Themes_for_vsCode/blob/main/github_package_modif.png?raw=true)
