# Thème sombre AMOLED avec un fond noir rgb(0,0,0) pour Visual Studio Code

## Description

Ce thème est basé sur les thèmes de l'extention GitHub Theme de Visual Studio Code.

Il a été créer pour les écrans AMOLED afin de réduire la consommation d'énergie, pour être plus agréable à l'oeil et pour avoir des commentaires bien plus visible que la plupart des autres thèmes.

Si les couleurs ne vous conviennent pas, vous pouvez les modifier dans le fichier `dark-perso.json` puis utiliser le script d'installation pour mettre à jour le thème sur votre IDE.

## Prévisualisation

### Règle générale

Ces règles s'appliquer à tous les langages.

- Fond : `noir`
- Mot clé et type prémitif : `Rouge`
- Commentaire : `Vert`
- Texte simple et ponctuation : `Blanc`
- Fonction : `Violet`
- Variable : `Jaune`
- Constante et texte entre quote : `Bleu`
- Type personnalisé / objet / commande : `Orange`
- Erreur : `Soulignement rouge`

### Exemple de code java et shell

![Préview java](./Images_readme/exemple_code_java.png)
![Préview shell](./Images_readme/exemple_code_shell.png)

## Prérequis

- Avoir installé Visual Studio Code

## Installation sur Linux (Tester sur Ubuntu 20.04 et ultérieur et sur Debian 12)

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

- Relancer Visual Studio Code
- Vous pouvez maintenant choisir le thème nommer `GitHub Dark Perso` dans les paramètres de l'extention Github Theme de Visual Studio Code
- Une fois le script exécuter, vous pouvez supprimer le repertoire `Themes_for_vsCode` cloner précédement

#### Manuellement

- Assurez vous d'avoir installé l'extension '`Github thème`' qui à comme ID :

  > GitHub.github-vscode-theme

  ![image extention github theme](./Images_readme/extention_github_theme.png)

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

- Relancer Visual Studio Code
- Vous pouvez maintenant choisir le thème nommer `GitHub Dark Perso` dans les paramètres de l'extention Github Theme de Visual Studio Code
- Une fois le thème choisi, vous pouvez supprimer le repertoire `Themes_for_vsCode` cloner précédement

## Installation sur Windows (Tester sur Windows 11)

### Avec le script d'installation

- Cloner le repertoire Github :

  ```batch
  git clone https://github.com/FloRobart/Themes_for_vsCode.git
  ```

- Executer la script '`installateur.bat`' en double cliquant dessus
- Relancer Visual Studio Code
- Vous pouvez maintenant choisir le thème nommer `GitHub Dark Perso` dans les paramètres de l'extention Github Theme de Visual Studio Code
- Une fois le script exécuter, vous pouvez supprimer le repertoire `Themes_for_vsCode` cloner précédement

### Manuellement

- Assurez vous d'avoir installé l'extension '`Github thème`' qui à comme ID :

  > GitHub.github-vscode-theme

  ![image extention github theme](./Images_readme/extention_github_theme.png)

- Cloner le repertoire Github :

  ```shell
  git clone https://github.com/FloRobart/Themes_for_vsCode.git
  ```

- Copier le thème dans le répertoire des thèmes de vscode :

  ```batch
  xcopy "path\to\Themes_for_vsCode\Themes\dark-perso.json" "C:\Users\%USERNAME%\.vscode\extensions\github.github-vscode-theme-< version >\themes\dark-perso.json"
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

- Relancer Visual Studio Code
- Vous pouvez maintenant choisir le thème nommer `GitHub Dark Perso` dans les paramètres de l'extention Github Theme de Visual Studio Code
- Une fois le thème choisi, vous pouvez supprimer le repertoire `Themes_for_vsCode` cloner précédement

## Report de bug

Si vous découvrez une erreur, quelquelle soit, cela peut êgre une faute de frappe ou d'orthographe, une erreur de calcul, une erreur de conception, un bug qui empêche le bon fonctionnement de l'application, ou tout autre problème, Merci de me le signaler par mail à l'adresse [florobart.github@gmail.com](mailto:florobart.github@gmail.com). Toutes les erreurs, quelque soit leur nature ou leur importance, seront traitées le plus rapidement possible.

## Licence

Account manager est un projet open-source sous licence [GNU General Public License v3.0](https://opensource.org/licenses/GPL-3.0).

