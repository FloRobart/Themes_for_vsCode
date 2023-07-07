# Thème sombre avec un fond noir rgb(0,0,0) pour Visual Studio Code

## Prévisualisation

## Installation

### Avec le script d'installation

- Cloner le repertoire Github :

  ```shell
  git clone https://github.com/FloRobart/Themes_for_vsCode.git
  ```

- Rendre le script executable :

  ```shell
  chmod +x installateur.sh
  ```

- Executer la script :

  ```shell
  ./installateur.sh
  ```

- Vous pouvez maintenant choisir le thème nommer `GitHub Dark Perso` dans les paramètres de vscode

### Manuellement

- Assurez vous d'avoir installé l'extension Github thème qui à comme ID :

> GitHub.github-vscode-theme

- Cloner le repertoire Github :

  ```shell
  git clone https://github.com/FloRobart/Themes_for_vsCode.git
  ```

- Copier le thème dans le répertoire des thèmes de vscode :

  ```shell
  cp "path/to/Themes_for_vsCode/Themes/dark-perso.json" "/home/$USER/.vscode/extensions/github.github-vscode-theme-< version >/themes/dark-perso.json"
  ```

- Modifier le fichier `package.json` pour y ajouter le nouveau thème

    Ajouter le texte suivant comme dans l'exemple si dessous

  ```json
  ,
  {
      "label": "GitHub Dark Perso",
      "uiTheme": "vs-dark",
      "path": "./themes/dark-perso.json"
  }
  ```

- Exemple

  ```json
  {
      ...
  
      "contributes": {
          "themes": [
  
              ...
  
              {
                  "label": "GitHub Dark",
                  "uiTheme": "vs-dark",
                  "path": "./themes/dark.json"
              },
              {
                  "label": "GitHub Dark Perso",
                  "uiTheme": "vs-dark",
                  "path": "./themes/dark-perso.json"
              }
          ]
      },
  
      ...
  }
  ```
