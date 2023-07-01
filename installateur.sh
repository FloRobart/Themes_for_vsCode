#!/bin/bash

#===========#
# Variables #
#===========#


#==========================================#
# Vérification de l'installation de vscode #
#==========================================#
verifVsCodeInstallation()
{
    verifVsCodeInstallation=$(code --version > /dev/null 2>&1 && echo 0 || echo 1)
    if [ $verifVsCodeInstallation -ne 0 ]
    then
        echo 'Visual Studio Code n'\''est pas installé, Voulez-vous l'\''installer ? (y/n)'
        read reponse
        if [ $reponse = "y" ] || [ $reponse = "Y" ] || [ $reponse = "yes" ] || [ $reponse = "Yes" ] || [ $reponse = "YES" ]
        then
            echo 'Installation de VsCode...'
            # Installation de VsCode
            installationVsCode && return 0 || return 1
        else
            echo 'VsCode ne sera pas installé'
            return 1
        fi
    else
        echo 'VsCode est déjà installé'
        return 0
    fi
}

#========================#
# Installation de vscode #
#========================#
installationVsCode()
{
    sudo apt update && ( sudo snap install code --classic && ( echo 'VsCode est installé' & return 0 ) || ( echo 'Une erreur s'est produite lors de l'installation de VsCode' & return 1 ) )
}



#=======================================#
# Demande d'installation du thème perso #
#=======================================#
demandeInstallationThemePerso()
{
    echo 'Voulez-vous installer le thème personnalisé ? (y/n)'
    read reponse
    if [ $reponse = "y" ] || [ $reponse = "Y" ] || [ $reponse = "yes" ] || [ $reponse = "Yes" ] || [ $reponse = "YES" ]
    then
        echo 'Installation du thème personnalisé...'
        return 0
    else
        echo 'Le thème personnalisé ne sera pas installé'
        return 1
    fi
}


#================================================#
# Vérification de l'installation de github thème #
#================================================#
verifExtentionGithubInstallation()
{
    verifExtentionGithubInstallation=$(code --list-extensions | grep 'GitHub.github-vscode-theme' > /dev/null 2>&1 && echo 0 || echo 1)
    if [ $verifExtentionGithubInstallation -ne 0 ]
    then
        echo 'L'\''extention Github thème n'\''est pas installé et est obligatoire pour installé le thème personnalisé. Voulez-vous installer l'\''extention ? (y/n)'
        read reponse
        if [ $reponse = "y" ] || [ $reponse = "Y" ] || [ $reponse = "yes" ] || [ $reponse = "Yes" ] || [ $reponse = "YES" ]
        then
            echo 'Installation du thème Github'
            # Installation de l'extention Github thème
            installationExtentionGithubTheme && return 0 || return 1
        else
            echo 'L'\''extention Github thème ne sera pas installé'
            return 1
        fi
    else
        echo 'L'\''extention Github thème est déjà installé'
        return 0
    fi
}


#=============================#
# Intallation de github thème #
#=============================#
installationExtentionGithubTheme()
{
    code --install-extension GitHub.github-vscode-theme && ( echo 'Le thème Github à été installé avec succès' & return 0 ) || ( echo 'Une erreur s'est produite lors de l'installation du thème Github' & return 1 )
}


#=====================================#
# Copie du fichier contenant le thème #
#=====================================#
copieFichierTheme()
{
    # récupération de la dernière version de l'extention
    ensFile=( $(ls -d ~/.vscode/extensions/github.github-vscode-theme-*) )
    # print all elements
    echo \'${ensFile[@]}\'

    #for FILE in github.github-vscode-theme-*; do echo $FILE; done

    #cp ./Themes/dark-perso.json ~/.vscode/extensions/$file/themes/dark-perso.json && return 0 || return 1
}



#============================================#
# Ajout du thème au fichier de configuration #
#============================================#
ajoutThemeInFichierConfiguration()
{
    echo 'Ajout du thème au fichier de configuration'
    return 0
}



#======#
# Main #
#======#
# Vérification de l'installation de vscode

# test
copieFichierTheme

# commande main final
#( verifVsCodeInstallation && demandeInstallationThemePerso && verifExtentionGithubInstallation && copieFichierTheme && ajoutThemeInFichierConfiguration ) && echo 'Installation réussi' || echo 'Une erreur s'\''est produite lors de l'\''installation'
