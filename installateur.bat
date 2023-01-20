@echo off
setlocal EnableDelayedExpansion
    ::----------::
    :: Variable ::
    ::----------::
    set "nameFileInstallExtension=installExtensionVscode-theme.vbs"
    set "nameFileSuppFileTemp=suppressionFileTemp.bat"
    set "nameFileOrig=%HomeDrive%%HomePath%\Downloads\dark-perso.json"

    for /f %%a in ('dir "%HomeDrive%%HomePath%\.vscode\extensions" /b /ad') do (
        echo %%a | findstr "github-vscode-theme">nul && (
            set "nameFolderTheme=%%a"
        )
    )

    set "nameFileDest=%HomeDrive%%HomePath%\.vscode\extensions\%nameFolderTheme%\themes\"

    SET "pathFilePackageJson=%HomeDrive%%HomePath%\.vscode\extensions\%nameFolderTheme%\package.json"



    :: suppression des fichiers temporaires ::
    IF EXIST ".\%nameFileInstallExtension%" del ".\%nameFileInstallExtension%"
    IF EXIST ".\%nameFileSuppFileTemp%"     del ".\%nameFileSuppFileTemp%"


    ::------::
    :: Main ::
    ::------::
    :: Verification de l'extension github theme ::
    code --list-extensions | findstr "GitHub.github-vscode-theme">nul && (
        :: copie du fichier dark-perso.json dans le dossier de l'extension github theme ::
        xcopy /Y "%nameFileOrig%" "%nameFileDest%" 2>nul >nul


        :: Ajout du theme dans le fichier package.json ::
        call :detecteLigneAjout
        call :ajoutTheme
        set "rien="
    ) || (
        :: Si l'extension github theme n'est pas installee, on demande a installer l'extension ::
        call :CreateConfirmInstallExtension
        start %nameFileInstallExtension%
    )
endlocal
goto :eof



:ajoutTheme
    set /a "cpt=1"
    for /f "skip=1 delims=" %%b in (' TYPE "!pathFilePackageJson!"') do (
        set /a "cpt+=1"
        if "!cpt!"=="2" ( echo {>"%pathFilePackageJson%" )

        if !cpt!==!numLigneModif! (
            echo %%b,>>"%pathFilePackageJson%"
            echo             {>>"%pathFilePackageJson%"
			echo                 "label": "GitHub Dark Perso",>>"%pathFilePackageJson%"
			echo                 "uiTheme": "vs-dark",>>"%pathFilePackageJson%"
			echo                 "path": "./themes/dark-perso.json">>"%pathFilePackageJson%"
			echo             }>>"%pathFilePackageJson%"
        ) else (
            echo %%b>>"%pathFilePackageJson%"
        )
    )
goto :eof


:detecteLigneAjout
    set /a "cpt=0"
    for /f "delims=" %%b in (' TYPE "%pathFilePackageJson%"') do (
        set /a "cpt+=1"
        echo %%b | findstr "]">nul && ( echo !a! | findstr "}">nul && ( set /a "numLigneModif=!cpt!-1" & goto :eof ))
        set "a=%%b"
    )
goto :eof



:CreateConfirmInstallExtension
echo @echo off> %nameFileSuppFileTemp%
    echo    IF EXIST ".\%nameFileInstallExtension%" del ".\%nameFileInstallExtension%">> %nameFileSuppFileTemp%
    echo    IF EXIST ".\%nameFileSuppFileTemp%"     del ".\%nameFileSuppFileTemp%">> %nameFileSuppFileTemp%
    echo goto :eof>> %nameFileSuppFileTemp%

    echo rep = MsgBox ^("L'extension github theme n'est pas installee." ^& vbcrlf ^& vbcrlf ^& "Voullez vous l'installer ?", vbYesNo + vbInformation, "Installation de l'extention"^)> %nameFileInstallExtension%
    echo if rep = vbYes then>> %nameFileInstallExtension%
    echo    prog = "installateur.bat installExtension">> %nameFileInstallExtension%
    echo    WScript.CreateObject ("Wscript.shell").run(prog), ^0>> %nameFileInstallExtension%
    echo else>> %nameFileInstallExtension%
    echo    wscript.echo "L'installation de l'extension n'a pas ete effectuee. Le theme n'a donc pas ete installe.">> %nameFileInstallExtension%
    echo    WScript.CreateObject ("Wscript.shell").run("%nameFileSuppFileTemp%"), ^0>> %nameFileInstallExtension%
    echo end if>> %nameFileInstallExtension%
goto :eof



:test


goto :eof