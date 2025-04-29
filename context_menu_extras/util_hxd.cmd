:: Adds "Open with HxD" entry to the Explorer context menu (hold Shift to activate)
:: [area] all files


@ECHO OFF
setlocal enabledelayedexpansion
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

for /f "tokens=* delims=" %%a in ('where HxD.exe 2^>nul') do set "HxD=%%a"
if exist !HxD! (
    reg add "HKCU\Software\Classes\*\shell\wincmd64_HxD" /v "MUIVerb" /d "Open with HxD" /f
    reg add "HKCU\Software\Classes\*\shell\wincmd64_HxD" /v "Icon" /d "!HxD!" /f
    reg add "HKCU\Software\Classes\*\shell\wincmd64_HxD" /v "Extended" /f
    reg add "HKCU\Software\Classes\*\shell\wincmd64_HxD\command" /ve /d "\"%HxD%\" \"%%1\"" /f
) else (color 4 & echo. & echo  HxD.exe not found. Try download from: https://mh-nexus.de/en/hxd & echo. & pause & exit)

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\*\shell\wincmd64_HxD" /f
color 27 & timeout 1
