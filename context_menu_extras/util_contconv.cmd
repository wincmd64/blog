:: Adds "Convert to HTM" entry to the Explorer context menu
:: [area] .vcf files


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

for /f "tokens=* delims=" %%a in ('where contconv.exe 2^>nul') do set "app=%%a"
if not exist "%app%" (color 4 & echo. & echo  contconv.exe not found. Try download from: https://github.com/DarkHobbit/doublecontact & echo. & pause & exit)

reg add "HKCU\Software\Classes\SystemFileAssociations\.vcf\shell\wincmd64_contconv" /v "MUIVerb" /d "Convert to HTM" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.vcf\shell\wincmd64_contconv" /v "Icon" /d "shell32.dll,91" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.vcf\shell\wincmd64_contconv" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.vcf\shell\wincmd64_contconv\command" /ve /d "cmd /c \"\"%app%\" -i \"%%1\" -o \"%%1.htm\" -f html -w ^& echo. ^& echo  Open \"%%1.htm\" ? ^& echo. ^& pause ^& start \"\" \"%%1.htm\"\"" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\SystemFileAssociations\.vcf\shell\wincmd64_contconv" /f
color 27 & timeout 1
