:: Adds "Image lossless compression" entry to the Explorer context menu (hold Shift to activate)
:: [area] dirs and .jpg .png .webp files


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

for /f "tokens=* delims=" %%a in ('where caesiumclt.exe 2^>nul') do set "app=%%a"
if not exist "%app%" (color 4 & echo. & echo  caesiumclt.exe not found. Try download from: https://github.com/Lymphatus/caesium-clt & echo. & pause & exit)

reg add "HKCU\Software\Classes\Directory\shell\wincmd64_caesium" /v "MUIVerb" /d "Image lossless compression" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_caesium" /v "Icon" /d "shell32.dll,80" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_caesium" /v "Extended" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_caesium\command" /ve /d "cmd /c \"\"%app%\" --lossless --exif --keep-dates --same-folder-as-input --overwrite bigger \"%%1\" ^& pause\"" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.jpg\shell\wincmd64_caesium" /v "MUIVerb" /d "Image lossless compression" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.jpg\shell\wincmd64_caesium" /v "Icon" /d "shell32.dll,80" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.jpg\shell\wincmd64_caesium" /v "Extended" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.jpg\shell\wincmd64_caesium\command" /ve /d "cmd /c \"\"%app%\" --lossless --exif --keep-dates --same-folder-as-input --overwrite bigger \"%%1\" ^& pause\"" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.png\shell\wincmd64_caesium" /v "MUIVerb" /d "Image lossless compression" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.png\shell\wincmd64_caesium" /v "Icon" /d "shell32.dll,80" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.png\shell\wincmd64_caesium" /v "Extended" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.png\shell\wincmd64_caesium\command" /ve /d "cmd /c \"\"%app%\" --lossless --exif --keep-dates --same-folder-as-input --overwrite bigger \"%%1\" ^& pause\"" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.webp\shell\wincmd64_caesium" /v "MUIVerb" /d "Image lossless compression" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.webp\shell\wincmd64_caesium" /v "Icon" /d "shell32.dll,80" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.webp\shell\wincmd64_caesium" /v "Extended" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.webp\shell\wincmd64_caesium\command" /ve /d "cmd /c \"\"%app%\" --lossless --exif --keep-dates --same-folder-as-input --overwrite bigger \"%%1\" ^& pause\"" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\Directory\shell\wincmd64_caesium" /f
reg delete "HKCU\Software\Classes\SystemFileAssociations\.jpg\shell\wincmd64_caesium" /f
reg delete "HKCU\Software\Classes\SystemFileAssociations\.png\shell\wincmd64_caesium" /f
reg delete "HKCU\Software\Classes\SystemFileAssociations\.webp\shell\wincmd64_caesium" /f
color 27 & timeout 1
