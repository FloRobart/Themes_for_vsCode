#!/bin/bash

#===========#
# Variables #
#===========#


#==========================================#
# Vérification de l'installation de vscode #
#==========================================#
verifVsCodeInstallation=$(code --version > /dev/null 2>&1 && echo 0 || echo 1)
verifVsCodeInstallation()
{
    if [ $verifVsCodeInstallation -ne 0 ]
    then
        echo 'VsCode n'\''est pas installé'
        echo 'Voulez-vous l'\''installer ? (y/n)'
        read reponse
        if [ $reponse = "y" ]
        then
            echo 'Installation de VsCode...'
            # Installation de VsCode
            installationVsCode

            return 0
        else
            echo 'VsCode ne sera pas installé'
        fi
    fi

    return 1
}

#========================#
# Installation de vscode #
#========================#
installationVsCode()
{
    sudo apt update && sudo snap install code --classic && echo 'VsCode est installé'
}


#================================================#
# Vérification de l'installation de github thème #
#================================================#
verifGithubThemeInstallation=$(code --list-extensions | grep 'GitHub.github-vscode-theme' > /dev/null 2>&1 && echo 0 || echo 1)
verifGithubThemeInstallation()
{
    if [ $verifGithubThemeInstallation -ne 0 ]
    then
        echo 'Le thème Github n'\''est pas installé'
        echo 'Voulez-vous l'\''installer ? (y/n)'
        read reponse
        if [ $reponse = "y" ]
        then
            echo 'Installation du thème Github'
            # Installation du thème Github
        else
            echo 'Le thème Github ne sera pas installé'
        fi
    fi
}


#=============================#
# Intallation de github thème #
#=============================#
installationGithubTheme()
{
    code --install-extension GitHub.github-vscode-theme
}


#=====================================#
# Copie du fichier contenant le thème #
#=====================================#



#============================================#
# Ajout du thème au fichier de configuration #
#============================================#



#======#
# Main #
#======#
# Vérification de l'installation de vscode
verifVsCodeInstallation && verifGithubThemeInstallation
