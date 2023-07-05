#!/bin/bash

#===========#
# Variables #
#===========#


#==========================================#
# Vérification de l'installation de vscode #
#==========================================#
function verifVsCodeInstallation()
{
    verifVsCodeInstallation=$(code --version > /dev/null 2>&1 && echo 0 || echo 1)
    if [ $verifVsCodeInstallation -ne 0 ]
    then
        echo 'Visual Studio Code n'\''est pas installé, Voulez-vous l'\''installer ? (y/n)'
        read reponse
        [[ ${reponse} =~ ^y(es)?$ ]] && installationVsCode || return 1
    fi

    return 0
}

#========================#
# Installation de vscode #
#========================#
function installationVsCode()
{
    sudo apt update && { sudo snap install code --classic && { echo 'VsCode à été installé avec succès' ; return 0 ; } || { echo 'Une erreur s'\''est produite lors de l'\''installation de VsCode' ; return 1 ; } } || { echo 'Une erreur s'\''est produite lors de l'\''update du gestionnaire de paquet apt' ; return 1 ; }
}



#=======================================#
# Demande d'installation du thème perso #
#=======================================#
function demandeInstallationThemePerso()
{
    echo 'Voulez-vous installer le thème personnalisé ? (y/n)'
    read reponse
    return $([[ ${reponse} =~ ^y(es)?$ ]])
}


#================================================#
# Vérification de l'installation de github thème #
#================================================#
function verifExtentionGithubInstallation()
{
    verifExtentionGithubInstallation=$(code --list-extensions | grep 'GitHub.github-vscode-theme' > /dev/null 2>&1 && echo 0 || echo 1)
    if [ $verifExtentionGithubInstallation -ne 0 ]
    then
        echo 'L'\''extention Github thème n'\''est pas installé et est obligatoire pour installé le thème personnalisé. Voulez-vous installer l'\''extention ? (y/n)'
        read reponse
        if [[ ${reponse} =~ ^y(es)?$ ]]
        then
            echo 'Installation du thème Github...'
            # Installation de l'extention Github thème
            installationExtentionGithubTheme && return 0 || { echo 'Une erreur est survenue lors de l'\''installation de l'\''extention Github thème' ; return 1 ; }
        else
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
function installationExtentionGithubTheme()
{
    code --install-extension GitHub.github-vscode-theme && { echo 'Le thème Github à été installé avec succès' ; return 0 ; } || return 1
}


#=====================================#
# Copie du fichier contenant le thème #
#=====================================#
function copieFichierTheme()
{
    #----------------------------------------------------#
    # récupération de la dernière version de l'extention #
    #----------------------------------------------------#
    ensFiles=($(ls -d ./Tests/github.github-vscode-theme-*))
    IFS=$'\n' ensFiles=($(sort <<<"${ensFiles[*]}")); unset IFS

    # Séparation du nom et des numéros versions
    i=0
    for value in "${ensFiles[@]}"
    do
        versions[$i]=$(echo $value | sed 's/.*-//')
        versions[$i]=$(retirePoint ${versions[$i]})
        ((i++))
    done

    # mise de toute les versions sur le même nombre de chiffre
    IFS=$'\n' versionsTrie=($(sort -n <<<"${versions[*]}")); unset IFS
    nbChiffre=${versionsTrie[ ${#versions[@]}-1 ]} ; nbChiffre=${#nbChiffre}
    i=0
    for value in "${versionsTrie[@]}"
    do
        [[ $nbChiffre -ne ${#value} ]] && versionsTrie[$i]="${versionsTrie[$i]}"'0'
        ((i++))
    done

    # récupération de la dernière version
    IFS=$'\n' versionsTrie=($(sort -n <<<"${versionsTrie[*]}")); unset IFS
    lastVersion=${versionsTrie[ ${#versions[@]}-1 ]}

    # récupération du nom du dossier correspondant à la dernière version
    getFolderNameLastversion
    [[ -z $lastFolder ]] && { lastVersion=$( sed 's/0$//' <<<"${lastVersion}" ) ; getFolderNameLastversion ; }
    lastFolder=$(sed 's/.*\///' <<<"${lastFolder}")

    #-------------------------------------#
    # Copie du fichier contenant le thème #
    #-------------------------------------#
    cp "./Themes/dark-perso.json" "~/.vscode/extensions/$lastFolder/themes/dark-perso.json"
}

function getFolderNameLastversion()
{
    i=0
    for value in "${ensFiles[@]}"
    do
        if [[ $(retirePoint ${versions[$i]}) -eq $lastVersion ]]
        then
            lastFolder=$value
            break
        fi
        ((i++))
    done
}

function retirePoint()
{
    echo $( echo $1 | sed 's/\.//' | sed 's/\.//' )
}


#============================================#
# Ajout du thème au fichier de configuration #
#============================================#
function ajoutThemeInFichierConfiguration()
{
    echo 'Ajout du thème au fichier de configuration'
    return 0
}



#======#
# Main #
#======#
# Vérification de l'installation de vscode

# commande main final
verifVsCodeInstallation && { echo 'Visual studio Code est déjà installé' ; vsCodeInstall=0 ; } || echo 'Visual studio Code ne sera pas installé'

if [[ -z $vsCodeInstall ]]
then
    if demandeInstallationThemePerso
    then
        echo 'Installation du thème personnalisé...'
        if verifExtentionGithubInstallation
        then
            echo 'copie du fichier contenant le thème...'
            if copieFichierTheme
            then
                echo 'Ajout du thème au fichier de configuration'
                if ajoutThemeInFichierConfiguration
                then
                    echo 'Installation réussi'
                else
                    echo 'Une erreur s'\''est produite lors de la modification du fichier de configuration'
                fi
            else
                echo 'Une erreur s'\''est produite lors de la copie du fichier contenant le thème'
            fi
        fi
    else
        echo 'Le thème personnalisé ne sera pas installé'
    fi
fi