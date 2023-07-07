@echo off

::======::
:: Main ::
::======::
:: Test
echo "code erreur : %ERRORLEVEL%"
echo "code succes : %SUCCESLEVEL%"

set /a "test=0"

if "%test%" EQU "0" (
    echo "true 1"
) else (
    echo "false 1"
)


exit /b

:: commande main final
call :verifVsCodeInstallation
if %verifVsCodeInstallation% (
    call :demandeInstallationThemePerso
    if %demandeInstallationThemePerso% (
        echo "Installation du thème personnalisé..."
        call :verifExtentionGithubInstallation
        if %verifExtentionGithubInstallation% (
            echo "copie du fichier contenant le thème..."
            call :copieFichierTheme
            if %copieFichierTheme% (
                echo "Ajout du thème au fichier de configuration..."
                call :ajoutThemeInFichierConfiguration
                if %ajoutThemeInFichierConfiguration% (
                    move $packageFile2 $packageFile && echo "Installation réussi" || echo "Une erreur s'est produite lors de la modification du fichier de configuration"
                ) else (
                    echo "Une erreur s'est produite lors de la modification du fichier de configuration"
                )
            ) else (
                echo "Une erreur s'est produite lors de la copie du fichier contenant le thème"
            )
        )
    ) else (
        echo "Le thème personnalisé ne sera pas installé"
    )
) else (
    if %erreur% EQU 0 (
        echo "Une erreur s'est produite lors de l'installation de VsCode"
    )
)


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