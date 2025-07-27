:: Adds "Open in Total Commander" entry to the Explorer context menu
:: [area] all files and dirs


@echo off
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

if exist "%COMMANDER_EXE%" (
    :: dirs
    reg add "HKCU\Software\Classes\Directory\shell\OpenTC" /v "MUIVerb" /d "Open in Total Commander" /f
    reg add "HKCU\Software\Classes\Directory\shell\OpenTC" /v "Icon" /d "%COMMANDER_EXE%" /f
    reg add "HKCU\Software\Classes\Directory\shell\OpenTC\command" /ve /d "%COMMANDER_EXE% /O /S /T /A /L=\"%%1\"" /f
    :: files
    reg add "HKCU\Software\Classes\*\shell\OpenTC" /v "MUIVerb" /d "Open in Total Commander" /f
    reg add "HKCU\Software\Classes\*\shell\OpenTC" /v "Icon" /d "%COMMANDER_EXE%" /f
    reg add "HKCU\Software\Classes\*\shell\OpenTC\command" /ve /d "%COMMANDER_EXE% /O /S /T /A /L=\"%%1\"" /f
) else (
    echo. & echo  Start TotalCommander and run this file again & echo.
    pause & exit
)

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\Directory\shell\OpenTC" /f
reg delete "HKCU\Software\Classes\*\shell\OpenTC" /f
color 27 & timeout 1
