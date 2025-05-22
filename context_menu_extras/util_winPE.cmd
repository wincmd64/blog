:: Adds "Boot now!" entry to the Explorer context menu
:: [area] .wim files


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

for /f "tokens=* delims=" %%a in ('where TBWinPE.exe 2^>nul') do set "TBWinPE=%%a"
if exist "%TBWinPE%" (
    reg add "HKCU\Software\Classes\SystemFileAssociations\.wim\shell\wincmd64_WIM" /v "MUIVerb" /d "Boot now!" /f
    reg add "HKCU\Software\Classes\SystemFileAssociations\.wim\shell\wincmd64_WIM" /v "Icon" /d "%TBWinPE%" /f
    reg add "HKCU\Software\Classes\SystemFileAssociations\.wim\shell\wincmd64_WIM" /v "Position" /d "Bottom" /f
    reg add "HKCU\Software\Classes\SystemFileAssociations\.wim\shell\wincmd64_WIM\command" /ve /d "\"%TBWinPE%\" /bootwim \"%%1\"" /f
) else (color 4 & echo. & echo  TBWinPE.exe not found. Try download from: https://www.terabyteunlimited.com/downloads/wp/tbwinpe.zip & echo. & pause & exit)

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\SystemFileAssociations\.wim\shell\wincmd64_WIM" /f
color 27 & timeout 1
