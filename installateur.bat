@echo off

REM Ce fichier fait partie du projet Thème for vscode
REM Copyright (C) 2024 Floris Robart florobart.github@gmail.com

::======::
:: Main ::
::======::
setlocal EnableDelayedExpansion
    call :verifVsCodeInstallation
    if "!verifVsCodeInstallation!" EQU "0" (
        call :demandeInstallationThemePerso
        if "!demandeInstallationThemePerso!" EQU "0" (
            call :verifExtentionGithubInstallation
            if "!verifExtentionGithubInstallation!" EQU "0" (
                echo copie du fichier contenant le theme...
                call :copieFichierTheme
            )
        ) else (
            echo Le theme personnalise ne sera pas installe, appuyer sur une touche pour quitter...
            pause >nul
        )
    ) else (
        if "%erreur%" EQU "0" (
            echo Une erreur s'est produite lors de l'installation de Visual Studio Code, appuyer sur une touche pour quitter...
            pause >nul
        ) else if "!erreur!" EQU "2" (
            echo Veuillez relancer le script pour installer le theme personnalise, appuyer sur une touche pour quitter...
            pause >nul
        )
    )
    endlocal
goto :EOF


::==========================================::
:: Vérification de l'installation de vscode ::
::==========================================::
:verifVsCodeInstallation
    code --version >nul 2>&1 && (
        echo Visual Studio Code est deja installe
        set /a "verifVsCodeInstallation=0"
    ) || (
        set /p "reponse=Visual Studio Code n'est pas installe, Voulez-vous l'installer ? (y/n) : "

        echo !reponse! | FINDSTR /I /R /C:"^y" >nul 2>&1 && (
            echo Installation de Visual Studio Code
            call :installationVsCode
            set /a "verifVsCodeInstallation=!installationVsCode!"
        ) || (
            echo Visual Studio Code ainsi que le theme ne seront pas installes, appuyer sur une touche pour quitter...
            pause >nul
            set /a "verifVsCodeInstallation=1"
            set /a "erreur=1"
        )
    )
goto :EOF


::========================::
:: Installation de vscode ::
::========================::
:installationVsCode
    echo Une fois le telechargement du fichier termine, fermer la fenetre du navigateur pour continuer l'installation
    start /wait https://code.visualstudio.com/docs/?dv=win && (
        if exist "%HomeDrive%%HomePath%\AppData\Local\Programs\Microsoft VS Code" (
            rmdir /S /Q "%HomeDrive%%HomePath%\AppData\Local\Programs\Microsoft VS Code"
        )

        for /f "USEBACKQ tokens=*" %%a in (`dir /B /O-D "%HomeDrive%%HomePath%\Downloads\VSCodeUserSetup-x64-*.exe"`) do set "file=%%a"

        if "!file!" NEQ "" (
            start /wait /D "%HomeDrive%%HomePath%\Downloads\" !file!

            if exist "%HomeDrive%%HomePath%\AppData\Local\Programs\Microsoft VS Code" (
                echo Visual Studio Code a ete installe avec succes
                set /a "installationVsCode=1"
                set /a "erreur=2"
            ) else (
                echo Visual Studio Code n'a pas ete installe, appuyer sur une touche pour quitter...
                pause >nul
                set /a "installationVsCode=1"
                set /a "erreur=1"
            )
        ) else (
            echo Le fichier d'installation de Visual Studio Code n'a pas ete trouve, appuyer sur une touche pour quitter...
            pause >nul
            set /a "installationVsCode=1"
            set /a "erreur=1"
        )
    ) || (
        set /a "installationVsCode=1"
        set /a "erreur=0"
    )
goto :EOF

::=======================================::
:: Demande d'installation du thème perso ::
::=======================================::
:demandeInstallationThemePerso
    set /p "reponse=Voulez-vous installer le theme personnalise ? (y/n) : "

    echo !reponse! | FINDSTR /I /R /C:"^y" >nul 2>&1 && (
        echo Installation du theme personnalise...
        set /a "demandeInstallationThemePerso=0"
    ) || (
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

        echo !reponse! | FINDSTR /I /R /C:"^y" >nul 2>&1 && (
            echo Installation de l'extention github theme...
            call :installationExtentionGithubTheme
            if "!installationExtentionGithubTheme!" EQU "0" (
                echo L'extention github theme a ete installe avec succes
                set /a "verifExtentionGithubInstallation=0"
            ) else (
                echo Une erreur s'est produite lors de l'installation de l'extention github theme
                set /a "verifExtentionGithubInstallation=1"
            )
        ) || (
            echo L'extention Github theme ainsi que le theme lui meme ne seront pas installe
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
    ::-------------------------------------::
    :: Copie du fichier contenant le thème ::
    ::-------------------------------------::
    for /f "USEBACKQ tokens=*" %%a in (`dir /B /OD "%HomeDrive%%HomePath%\.vscode\extensions\github.github-vscode-theme-*"`) do (
        SET "pathFilePackageJson=%HomeDrive%%HomePath%\.vscode\extensions\%%a\package.json"
        set /a "cpt+=1"
        xcopy /Y /Q ".\Themes\dark-perso.json" "%HomeDrive%%HomePath%\.vscode\extensions\%%a\themes\" && (
            call :ajoutThemeInFichierConfiguration
        ) || (
            echo Une erreur s'est produite lors de la copie du fichier contenant le theme
            set /a "erreur=1" 
        )
    )

    if "!erreur!" NEQ "1" (
        echo Le theme personnalise a ete installe avec succes, appuyer sur une touche pour quitter...
        pause >nul
    )
goto :EOF


::============================================::
:: Ajout du thème au fichier de configuration ::
::============================================::
:ajoutThemeInFichierConfiguration
    call :detecteLigneAjout
    set /a "cpt=1"
    for /f "skip=1 delims=" %%b in (' TYPE "!pathFilePackageJson!"') do (
        set /a "cpt+=1"
        if "!cpt!"=="2" ( echo {>"!pathFilePackageJson!" )

        if !cpt!==!numLigneModif! (
            echo %%b>>"!pathFilePackageJson!"
            echo             {>>"!pathFilePackageJson!"
			echo                 "label": "GitHub Dark Perso",>>"!pathFilePackageJson!"
			echo                 "uiTheme": "vs-dark",>>"!pathFilePackageJson!"
			echo                 "path": "./themes/dark-perso.json">>"!pathFilePackageJson!"
			echo             },>>"!pathFilePackageJson!"
        ) else (
            echo %%b>>"!pathFilePackageJson!"
        )
    )
goto :EOF

:detecteLigneAjout
    set /a "cpt=0"
    for /f "delims=" %%b in (' TYPE "!pathFilePackageJson!"') do (
        set /a "cpt+=1"
        echo %%b | findstr /I /R /C:".themes.: \[">nul 2>&1 && ( set /a "numLigneModif=!cpt!" & goto :eof )
    )
goto :eof