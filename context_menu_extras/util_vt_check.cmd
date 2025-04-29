:: Adds "VirusTotal" menu entry to the Explorer context menu
:: [area] all files and dirs


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

:find
for /f "tokens=* delims=" %%a in ('where sigcheck64.exe 2^>nul') do set "sigcheck=%%a"
if exist "%sigcheck%" (
    reg add "HKCU\Software\Classes\*\shell\wincmd64_sigcheck" /v "MUIVerb" /d "VirusTotal" /f
    reg add "HKCU\Software\Classes\*\shell\wincmd64_sigcheck" /v "Icon" /d "shell32.dll,22" /f
    reg add "HKCU\Software\Classes\*\shell\wincmd64_sigcheck" /v "SubCommands" /f

    reg add "HKCU\Software\Classes\*\shell\wincmd64_sigcheck\shell\01v" /v "MUIVerb" /d "Query" /f
    reg add "HKCU\Software\Classes\*\shell\wincmd64_sigcheck\shell\01v\command" /ve /d "cmd.exe /c \"\"%sigcheck%\" -nobanner -accepteula -vt -v \"%%1\" ^& pause\"" /f

    reg add "HKCU\Software\Classes\*\shell\wincmd64_sigcheck\shell\02vrs" /v "MUIVerb" /d "Upload and report" /f
    reg add "HKCU\Software\Classes\*\shell\wincmd64_sigcheck\shell\02vrs\command" /ve /d "cmd.exe /c \"\"%sigcheck%\" -nobanner -accepteula -vt -vrs \"%%1\" ^& pause\"" /f


    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sigcheck" /v "MUIVerb" /d "VirusTotal" /f
    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sigcheck" /v "Icon" /d "shell32.dll,22" /f
    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sigcheck" /v "SubCommands" /f

    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sigcheck\shell\01v" /v "MUIVerb" /d "Query" /f
    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sigcheck\shell\01v\command" /ve /d "cmd.exe /c \"\"%sigcheck%\" -nobanner -accepteula -vt -v \"%%1\" ^& pause\"" /f

    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sigcheck\shell\02vrs" /v "MUIVerb" /d "Upload and report" /f
    reg add "HKCU\Software\Classes\Directory\shell\wincmd64_sigcheck\shell\02vrs\command" /ve /d "cmd.exe /c \"\"%sigcheck%\" -nobanner -accepteula -vt -vrs \"%%1\" ^& pause\"" /f
) else (
    echo. & echo  SigCheck not found. Try to download? & echo.
    pause
    curl.exe -RO# "https://live.sysinternals.com/sigcheck64.exe"
    goto find
)

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\*\shell\wincmd64_sigcheck" /f
reg delete "HKCU\Software\Classes\Directory\shell\wincmd64_sigcheck" /f
color 27 & timeout 1
