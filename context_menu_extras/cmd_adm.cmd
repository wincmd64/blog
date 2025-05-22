:: Adds "Open CMD here as admin" entry to the Explorer context menu (hold Shift to activate)
:: [area] dirs dackground


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

reg add "HKCU\Software\Classes\Directory\Background\shell\wincmd64_cmd" /v "MUIVerb" /d "Open CMD here as admin" /f
reg add "HKCU\Software\Classes\Directory\Background\shell\wincmd64_cmd" /v "Icon" /d "cmd.exe" /f
reg add "HKCU\Software\Classes\Directory\Background\shell\wincmd64_cmd" /v "HasLUAShield" /f
reg add "HKCU\Software\Classes\Directory\Background\shell\wincmd64_cmd" /v "Extended" /f
reg add "HKCU\Software\Classes\Directory\Background\shell\wincmd64_cmd\command" /ve /d "powershell.exe -NoP -w Hidden -c \"Start-Process -Verb RunAs cmd.exe -ArgumentList '/k pushd \"%%V\"'\"" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\Directory\Background\shell\wincmd64_cmd" /f
color 27 & timeout 1
