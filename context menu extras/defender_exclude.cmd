:: Adds "Defender exclusions" menu entry to the Explorer context menu (hold Shift to activate)
:: [area] all files and dirs


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList" /v "MUIVerb" /d "Def exclusions" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList" /v "Icon" /d "%%ProgramFiles%%\Windows Defender\EppManifest.dll" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList" /v "Extended" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList" /v "SubCommands" /f

reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList\shell\01add" /v "MUIVerb" /d "Add" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList\shell\01add" /v "Icon" /d "imageres.dll,101" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList\shell\01add\command" /ve /d "powershell -WindowStyle Hidden -Command \"start powershell -Verb runas -ArgumentList \\\"-command `\\\"Add-MpPreference -ExclusionPath '%%1'`\\\"\\\"\"" /f

reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList\shell\02del" /v "MUIVerb" /d "Remove" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList\shell\02del" /v "Icon" /d "imageres.dll,100" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList\shell\02del\command" /ve /d "powershell -WindowStyle Hidden -Command \"start powershell -Verb runas -ArgumentList \\\"-command `\\\"Remove-MpPreference -ExclusionPath '%%1'`\\\"\\\"\"" /f

reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList\shell\03list" /v "MUIVerb" /d "Exclusions list" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList\shell\03list" /v "Icon" /d "imageres.dll,99" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_DefList\shell\03list\command" /ve /d "explorer windowsdefender://exclusions" /f


reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList" /v "MUIVerb" /d "Def exclusions" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList" /v "Icon" /d "%%ProgramFiles%%\Windows Defender\EppManifest.dll" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList" /v "Extended" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList" /v "SubCommands" /f

reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList\shell\01add" /v "MUIVerb" /d "Add" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList\shell\01add" /v "Icon" /d "imageres.dll,101" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList\shell\01add\command" /ve /d "powershell -WindowStyle Hidden -Command \"start powershell -Verb runas -ArgumentList \\\"-command `\\\"Add-MpPreference -ExclusionPath '%%1'`\\\"\\\"\"" /f

reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList\shell\02del" /v "MUIVerb" /d "Remove" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList\shell\02del" /v "Icon" /d "imageres.dll,100" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList\shell\02del\command" /ve /d "powershell -WindowStyle Hidden -Command \"start powershell -Verb runas -ArgumentList \\\"-command `\\\"Remove-MpPreference -ExclusionPath '%%1'`\\\"\\\"\"" /f

reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList\shell\03list" /v "MUIVerb" /d "Exclusions list" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList\shell\03list" /v "Icon" /d "imageres.dll,99" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DefList\shell\03list\command" /ve /d "explorer windowsdefender://exclusions" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\*\shell\wincmd64_DefList" /f
reg delete "HKCU\Software\Classes\Directory\shell\wincmd64_DefList" /f
color 27 & timeout 1
