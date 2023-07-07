@echo off

::==========================================::
:: Vérification de l'installation de vscode ::
::==========================================::
:verifVsCodeInstallation

goto :EOF

::========================::
:: Installation de vscode ::
::========================::
:installationVsCode

goto :EOF



::=======================================::
:: Demande d'installation du thème perso ::
::=======================================::
:demandeInstallationThemePerso

goto :EOF


::================================================::
:: Vérification de l'installation de github thème ::
::================================================::
:verifExtentionGithubInstallation

goto :EOF


::=============================::
:: Intallation de github thème ::
::=============================::
:installationExtentionGithubTheme

goto :EOF


::=====================================::
:: Copie du fichier contenant le thème ::
::=====================================::
:copieFichierTheme
    ::----------------------------------------------------::
    :: récupération de la dernière version de l'extention ::
    ::----------------------------------------------------::

    :: Séparation du nom et des numéros versions


    :: mise de toute les versions sur le même nombre de chiffre


    :: récupération de la dernière version

    :: récupération du nom du dossier correspondant à la dernière version


    ::-------------------------------------::
    :: Copie du fichier contenant le thème ::
    ::-------------------------------------::


goto :EOF



::============================================::
:: Ajout du thème au fichier de configuration ::
::============================================::
:ajoutThemeInFichierConfiguration

goto :EOF



::======::
:: Main ::
::======::
:: commande main final
if verifVsCodeInstallation
then
    if demandeInstallationThemePerso
    then
        echo 'Installation du thème personnalisé...'
        if verifExtentionGithubInstallation
        then
            echo 'copie du fichier contenant le thème...'
            if copieFichierTheme
            then
                echo 'Ajout du thème au fichier de configuration...'
                if ajoutThemeInFichierConfiguration
                then
                    mv $packageFile2 $packageFile && echo 'Installation réussi' || echo 'Une erreur s'\''est produite lors de la modification du fichier de configuration'
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
else
    if [ $erreur -eq 0 ]
    then
        echo 'Une erreur s'\''est produite lors de l'\''installation de VsCode'
    fi
fi