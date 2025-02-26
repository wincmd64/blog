:: Adds "Secure Delete" entry to the Explorer context menu
:: [area] all files and dirs


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

:find
for /f "tokens=* delims=" %%a in ('where sdelete64.exe') do set "sdelete=%%a"
if exist "%sdelete%" (
    reg add "HKCU\Software\Classes\*\shell\wincmd64_sdelete" /v "MUIVerb" /d "Secure Delete" /f
    reg add "HKCU\Software\Classes\*\shell\wincmd64_sdelete" /v "Icon" /d "imageres.dll,-5320" /f
    reg add "HKCU\Software\Classes\*\shell\wincmd64_sdelete" /v "Extended" /f
    reg add "HKCU\Software\Classes\*\shell\wincmd64_sdelete" /v "NoWorkingDirectory" /f
    reg add "HKCU\Software\Classes\*\shell\wincmd64_sdelete\command" /ve /d "cmd.exe /c \"\"%sdelete%\" -nobanner -s \"%%1\" ^& pause\"" /f

    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sdelete" /v "MUIVerb" /d "Secure Delete" /f
    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sdelete" /v "Icon" /d "imageres.dll,-5320" /f
    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sdelete" /v "Extended" /f
    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sdelete" /v "NoWorkingDirectory" /f
    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sdelete\command" /ve /d "cmd.exe /c \"\"%sdelete%\" -nobanner -s \"%%1\" ^& pause\"" /f
) else (
    echo. & echo sdelete not found. Try to download? & echo.
    pause
    curl.exe -RO# "https://live.sysinternals.com/sdelete64.exe"
    goto find
)

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\*\shell\wincmd64_sdelete" /f
reg delete "HKCU\Software\Classes\Directory\shell\wincmd64_sdelete" /f
color 27 & timeout 1
