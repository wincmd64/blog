:: Adds "View content" entry to the Explorer context menu
:: [area] .dbf files


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

:find
for /f "tokens=* delims=" %%a in ('where DBFPlus.exe 2^>nul') do set "DBFPlus=%%a"
if exist "%DBFPlus%" (
    reg add "HKCU\Software\Classes\SystemFileAssociations\.dbf\shell\wincmd64_dbf" /v "MUIVerb" /d "View content" /f
    reg add "HKCU\Software\Classes\SystemFileAssociations\.dbf\shell\wincmd64_dbf" /v "Icon" /d "%DBFPlus%" /f
    reg add "HKCU\Software\Classes\SystemFileAssociations\.dbf\shell\wincmd64_dbf" /v "Position" /d "Bottom" /f
    reg add "HKCU\Software\Classes\SystemFileAssociations\.dbf\shell\wincmd64_dbf\command" /ve /d "\"%DBFPlus%\" \"%%1\"" /f
) else (
    echo. & echo  DBFPlus.exe not found. Try to download? & echo.
    pause
    curl.exe -RO# "http://www.alexnolan.net/software/DBFPlus.exe"
    goto find
)

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\SystemFileAssociations\.dbf\shell\wincmd64_dbf" /f
color 27 & timeout 1
