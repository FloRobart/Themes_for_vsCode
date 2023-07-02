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
    # ~/.vscode/extensions/
    ensFile=($(ls -d ./Tests/github.github-vscode-theme-*))
    IFS=$'\n' ensFile=($(sort <<<"${ensFile[*]}")); unset IFS

    i=0
    for value in "${ensFile[@]}"
    do
        # Séparation des versions
        version[$i]=$(echo $value | sed 's/.*-//' | sed 's/\.//' | sed 's/\.//')
        ((i++))
    done

    printf '%s, ' "${version[@]}"
    echo -e

    # mise de toute les versions sur le même nombre de chiffre
    IFS=$'\n' version=($(sort -n <<<"${version[*]}")); unset IFS

    nbChiffre=${version[ ${#version[@]}-1 ]}
    i=0
    for value in "${version[@]}"
    do
        if [ $nbChiffre -ne $value ]
        then
            version[$i]=${version[$i]}0
        fi
        ((i++))
    done

    IFS=$'\n' version=($(sort -n <<<"${version[*]}")); unset IFS

    printf '%s, ' "${version[@]}"
    echo -e

    # Récupération du fichier avec le bon numéro de version

: << 'END'
    #---------------------------------------------------#
    # récupération des versions des extentions trouvées #
    #---------------------------------------------------#
    i=0
    for value in "${ensFile[@]}"
    do
        # Séparation des versions (majeur, mineur, patch)
        version=$(echo $value | sed 's/.*-//')
        majeur[$i]=$(echo $version | sed 's/\.[0-9]*\.[0-9]*$//') # version majeur
        mineur[$i]=$(echo $version | sed 's/^[0-9]*\.//' | sed 's/\.[0-9]*$//') # version mineur
        patch[$i]=$(echo $version | sed 's/^[0-9]*\.[0-9]*\.//') # patch

        #echo $version ' --> ' ${majeur[$i]}, ${mineur[$i]}, ${patch[$i]}
        ((i++))
    done


    #---------------------------------------------#
    # Suppression des versions les moins récentes #
    #---------------------------------------------#
    IFS=$'\n' majeurSorted=($(sort -n <<<"${majeur[*]}")); unset IFS

    printf '%s, ' "${majeur[@]}"
    echo -e
    printf '%s, ' "${mineur[@]}"
    echo -e
    printf '%s, ' "${patch[@]}"
    echo -e "\n"

    i=0
    lastMajeur=${majeurSorted[ ${#majeurSorted[@]}-1 ]} # dernière version majeur
    for value in "${majeur[@]}"
    do
        if [ $value -ne $lastMajeur ]
        then
            unset majeur[$i]
            unset mineur[$i]
            unset patch[$i]
        fi
        ((i++))
    done

    echo 'Version majeur :'
    printf '%d, ' "${majeur[@]}"
    echo -e
    printf '%d, ' "${mineur[@]}"
    echo -e
    printf '%d, ' "${patch[@]}"
    echo -e "\n"

    IFS=$'\n' mineurSorted=($(sort -n <<<"${mineur[*]}")); unset IFS

    i=0
    lastMineur=${mineurSorted[ ${#mineurSorted[@]}-1 ]} # dernière version mineur
    for value in "${mineur[@]}"
    do
        if [ $value -ne $lastMineur ]
        then
            unset majeur[$i]
            unset mineur[$i]
            unset patch[$i]
        fi
        ((i++))
    done

    echo 'Version mineur :'
    printf '%d, ' "${majeur[@]}"
    echo -e
    printf '%d, ' "${mineur[@]}"
    echo -e
    printf '%d, ' "${patch[@]}"
    echo -e "\n"

    IFS=$'\n' patchSorted=($(sort -n <<<"${patch[*]}")); unset IFS

    ((i=0))
    lastPatch=${patchSorted[ ${#patchSorted[@]}-1 ]} # dernière version patch
    for value in "${patch[@]}"
    do
        if [ $value -ne $lastPatch ]
        then
            unset majeur[$i]
            unset mineur[$i]
            unset patch[$i]
        fi
        ((i++))
    done

    echo 'Version patch :'
    printf '%d, ' "${majeur[@]}"
    echo -e
    printf '%d, ' "${mineur[@]}"
    echo -e
    printf '%d, ' "${patch[@]}"
    echo -e "\n"


    #-------------------------------------#
    # récupération de la dernière version #
    #-------------------------------------#



    #--------------------------------#
    # récupération du nom du fichier #
    #--------------------------------#



    #------------------------------------------#
    # copie du fichier dans le dossier .vscode #
    #------------------------------------------#
    #cp ./Themes/dark-perso.json ~/.vscode/extensions/$finalFile/themes/dark-perso.json && return 0 || return 1

END
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
