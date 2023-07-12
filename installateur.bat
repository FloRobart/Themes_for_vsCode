@echo off

::======::
:: Main ::
::======::
setlocal EnableDelayedExpansion
    call :verifVsCodeInstallation
    if "%verifVsCodeInstallation%" EQU "0" (
        goto :EOF
        call :demandeInstallationThemePerso
        if "%demandeInstallationThemePerso%" EQU "0" (
            echo "Installation du thème personnalisé..."
            call :verifExtentionGithubInstallation
            if "%verifExtentionGithubInstallation%" EQU "0" (
                echo "copie du fichier contenant le thème..."
                call :copieFichierTheme
                if "%copieFichierTheme%" EQU "0" (
                    echo "Ajout du thème au fichier de configuration..."
                    call :ajoutThemeInFichierConfiguration
                    if "%ajoutThemeInFichierConfiguration%" EQU "0" (
                        move "%packageFile2% %packageFile%" && echo "Installation réussi" || echo "Une erreur s'est produite lors de la modification du fichier de configuration"
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
        if "%erreur%" EQU "0" (
            echo "Une erreur s'est produite lors de l'installation de VsCode"
        )
    )
    endlocal
goto :EOF


::==========================================::
:: Vérification de l'installation de vscode ::
::==========================================::
:verifVsCodeInstallation
    call code --version >nul 2>&1 && ( set /a "verifVsCodeInstallation=0" ) || ( set /a "verifVsCodeInstallation=1" )

    code --version >nul 2>&1 && (
        echo Visual studio Code est déjà installe
    ) || (
        set /p "reponse=Visual Studio Code n'est pas installe, Voulez-vous l'installer ? (y/n) : "

        echo !reponse! | FINDSTR /I /R /C:"^y" && (
            echo Installation de Visual Studio Code
            call :installationVsCode
            set /a "verifVsCodeInstallation=0"
            goto :EOF
        ) || (
            echo Visual Studio Code ne sera pas installe
            set /a "verifVsCodeInstallation=1"
            goto :EOF
        )
    )
goto :EOF


::========================::
:: Installation de vscode ::
::========================::
:installationVsCode
    echo en cours d'installation
    start /wait https://code.visualstudio.com/docs/?dv=win && (
        set /a "cpt=0"
        echo Telechargement reussi
        :waitFileVsCode
            timeout /t 5 >nul 2>&1
            FOR /F "usebackq" %%a IN (`dir /B /O-D "VSCodeUserSetup-x64-*"`) do ( set fileVsCode=%%a & exit )
            echo '%fileVsCode%'
            echo '!fileVsCode!'
            goto :EOF

            if exist "VSCodeUserSetup-x64-*.exe" (
                echo Visual Studio Code vas etre installe
                echo "C:\%USER%\Downloads\VSCodeUserSetup-x64-*.exe"
                call "C:\%USER%\Downloads\VSCodeUserSetup-x64-*.exe" && echo Installation reussi
            ) else (
                if "%cpt%" EQU "5" (
                    echo "Une erreur s'est produite lors de l'installation de VsCode"
                    set /a "erreur=1"
                    goto :EOF
                )
                echo relance de la boucle
                goto :waitFileVsCode
            )
    ) || (
        echo "Une erreur s'est produite lors de l'installation de VsCode"
    )
goto :EOF

Set "Search=abcd_*_*"
Set cnt=0
for /f "tokens=1* delims=:" %%A in (
  'dir /B /ON /A-D "%Search%" ^|Findstr /i /n "^" '
) do set "File[%%A]=%%~B"&Set Cnt=%%A
Echo Search "%Search%" got %Cnt% result(s)
For /L %%C in (1,1,%Cnt%) Do Set File[%%C]

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