:: Adds "InnoSetup unPacker" entry to the Explorer context menu (hold Shift to activate)
:: [area] .exe files


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

for /f "tokens=* delims=" %%a in ('where innounp.exe 2^>nul') do set "innounp=%%a"
if not exist "%innounp%" (color 4 & echo. & echo  innounp.exe not found. Try download from: https://www.rathlev-home.de/tools/download/innounp-2.zip & echo. & pause & exit)

reg add "HKCU\Software\Classes\exefile\shell\wincmd64_inno" /v "MUIVerb" /d "InnoSetup unPacker" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_inno" /v "Icon" /d "%innounp%" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_inno" /v "Extended" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_inno\command" /ve /d "cmd /c \"\"%innounp%\" -x \"%%1\" ^& pause\"" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\exefile\shell\wincmd64_inno" /f
color 27 & timeout 1
