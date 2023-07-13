@echo off

::======::
:: Main ::
::======::
setlocal EnableDelayedExpansion
    call :verifVsCodeInstallation
    if "%verifVsCodeInstallation%" EQU "0" (
        call :demandeInstallationThemePerso
        if "!demandeInstallationThemePerso!" EQU "0" (
            echo Installation du theme personnalise...
            call :verifExtentionGithubInstallation
            goto :EOF
            if "%verifExtentionGithubInstallation%" EQU "0" (
                echo copie du fichier contenant le theme...
                call :copieFichierTheme
                if "%copieFichierTheme%" EQU "0" (
                    echo Ajout du theme au fichier de configuration...
                    call :ajoutThemeInFichierConfiguration
                    if "%ajoutThemeInFichierConfiguration%" EQU "0" (
                        move "%packageFile2% %packageFile%" && echo Installation reussi || echo Une erreur s'est produite lors de la modification du fichier de configuration
                    ) else (
                        echo eUne erreur s'est produite lors de la modification du fichier de configuratione
                    )
                ) else (
                    echo Une erreur s'est produite lors de la copie du fichier contenant le theme
                )
            )
        ) else (
            echo Le theme personnalise ne sera pas installe
        )
    ) else (
        if "%erreur%" EQU "0" (
            echo Une erreur s'est produite lors de l'installation de VsCode
        )
    )
    endlocal
goto :EOF


::==========================================::
:: Vérification de l'installation de vscode ::
::==========================================::
:verifVsCodeInstallation
    call code --version >nul 2>&1 && ( set /a "verifVsCodeInstallation=0" ) || ( set /a "verifVsCodeInstallation=1" & set /a "erreur=0" )

    code --version >nul 2>&1 && (
        echo Visual Studio Code est deja installe
        set /a "verifVsCodeInstallation=0"
    ) || (
        set /p "reponse=Visual Studio Code n'est pas installe, Voulez-vous l'installer ? (y/n) : "

        echo !reponse! | FINDSTR /I /R /C:"^y" && (
            echo Installation de Visual Studio Code
            call :installationVsCode
            set /a "verifVsCodeInstallation=0"
        ) || (
            echo Visual Studio Code ne sera pas installe
            set /a "verifVsCodeInstallation=1"
            set /a "erreur=1"
        )
    )
goto :EOF


::========================::
:: Installation de vscode ::
::========================::
:installationVsCode
    echo Une fois le telechargement termine, fermer la fenetre du navigateur pour continuer l'installation
    start /wait https://code.visualstudio.com/docs/?dv=win && (
        for /f "USEBACKQ tokens=*" %%a in (`dir /B /OD "'C:\Users\%USERNAME%\Downloads\VSCodeUserSetup-x64-*.exe'"`) do set "file=%%a"
        start /wait /D "C:\Users\%USERNAME%\Downloads\" !file!
        echo Installation de Visual Studio Code terminee
    ) || (
        echo Une erreur s'est produite lors de l'installation de Visual Studio Code
    )
goto :EOF

::=======================================::
:: Demande d'installation du thème perso ::
::=======================================::
:demandeInstallationThemePerso
    set /p "reponse=Voulez-vous installer le theme personnalise ? (y/n) : "

    echo reponse '!reponse!'
    echo !reponse! | FINDSTR /I /R /C:"^y" && (
        echo Installation du theme personnalise
        set /a "demandeInstallationThemePerso=0"
    ) || (
        echo Le theme personnalise ne sera pas installe
        set /a "demandeInstallationThemePerso=1"
    )
goto :EOF


::================================================::
:: Vérification de l'installation de github thème ::
::================================================::
:verifExtentionGithubInstallation
    code --list-extensions | FINDSTR /I /R /C:"^GitHub\.github\-vscode\-theme*" >nul 2>&1 && (
        echo L'extention github theme est deja installe
        set /a "verifExtentionGithubInstallation=0"
    ) || (
        set /p "reponse=L'extention Github theme n'est pas installe et est obligatoire pour installe le theme personnalise. Voulez-vous installer l'extention ? (y/n) : "

        echo !reponse! | FINDSTR /I /R /C:"^y" && (
            echo Installation de l'extention github theme...
            call :installationExtentionGithubTheme
            if "!installationExtentionGithubTheme!" EQU "0" (
                echo L'extention github theme a ete installe
                set /a "verifExtentionGithubInstallation=0"
            ) else (
                echo Une erreur s'est produite lors de l'installation de l'extention github theme
                set /a "verifExtentionGithubInstallation=1"
            )
        ) || (
            echo L'exention github theme ne sera pas installe
            set /a "verifExtentionGithubInstallation=1"
        )
    )
goto :EOF


::=============================::
:: Intallation de github thème ::
::=============================::
:installationExtentionGithubTheme
    code --install-extension GitHub.github-vscode-theme && set /a "installationExtentionGithubTheme=0" || set /a "installationExtentionGithubTheme=1"
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