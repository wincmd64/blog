:: Adds "Add to Task Scheduler" entry to the Explorer context menu (hold Shift to activate)
:: [area] .exe .cmd .bat .ps1 files


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

reg add "HKCU\Software\Classes\exefile\shell\wincmd64_AddSchtasks" /v "MUIVerb" /d "Add to Task Scheduler" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_AddSchtasks" /v "Icon" /d "shell32.dll,20" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_AddSchtasks" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_AddSchtasks" /v "Extended" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_AddSchtasks" /v "HasLUAShield" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_AddSchtasks\command" /ve /d "mshta.exe VBScript:Close(CreateObject(\"Shell.Application\").ShellExecute(\"cmd\",\"/D /C (for /F \"\"Tokens=2,*\"\" %%%%i in ('REG QUERY \"\"HKCU\Software\Classes\exefile\shell\wincmd64_AddSchtasks\command\"\" /V execute') do set \"\"$$=%%1\"\" ^&^& cmd /D /C %%%%j)\",\"\",\"RunAs\",0))" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_AddSchtasks\command" /v execute /d "for /F \"Tokens=*\" %%i in (\"%%$$%%\") do (schtasks /Create /TN \"WithoutUAC %%~ni\" /TR \"mshta.exe VBScript:Close(CreateObject('Shell.Application').ShellExecute('%%~i','','','RunAs',0))\" /SC ONLOGON /F /RL HIGHEST)" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.cmd\shell\wincmd64_AddSchtasks" /v "MUIVerb" /d "Add to Task Scheduler" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.cmd\shell\wincmd64_AddSchtasks" /v "Icon" /d "shell32.dll,20" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.cmd\shell\wincmd64_AddSchtasks" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.cmd\shell\wincmd64_AddSchtasks" /v "Extended" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.cmd\shell\wincmd64_AddSchtasks" /v "HasLUAShield" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.cmd\shell\wincmd64_AddSchtasks\command" /ve /d "mshta.exe VBScript:Close(CreateObject(\"Shell.Application\").ShellExecute(\"cmd\",\"/D /C (for /F \"\"Tokens=2,*\"\" %%%%i in ('REG QUERY \"\"HKCU\Software\Classes\SystemFileAssociations\.cmd\shell\wincmd64_AddSchtasks\command\"\" /V execute') do set \"\"$$=%%1\"\" ^&^& cmd /D /C %%%%j)\",\"\",\"RunAs\",0))" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.cmd\shell\wincmd64_AddSchtasks\command" /v execute /d "for /F \"Tokens=*\" %%i in (\"%%$$%%\") do (schtasks /Create /TN \"WithoutUAC %%~ni\" /TR \"mshta.exe VBScript:Close(CreateObject('Shell.Application').ShellExecute('%%~i','','','RunAs',0))\" /SC ONLOGON /F /RL HIGHEST)" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.bat\shell\wincmd64_AddSchtasks" /v "MUIVerb" /d "Add to Task Scheduler" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.bat\shell\wincmd64_AddSchtasks" /v "Icon" /d "shell32.dll,20" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.bat\shell\wincmd64_AddSchtasks" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.bat\shell\wincmd64_AddSchtasks" /v "Extended" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.bat\shell\wincmd64_AddSchtasks" /v "HasLUAShield" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.bat\shell\wincmd64_AddSchtasks\command" /ve /d "mshta.exe VBScript:Close(CreateObject(\"Shell.Application\").ShellExecute(\"cmd\",\"/D /C (for /F \"\"Tokens=2,*\"\" %%%%i in ('REG QUERY \"\"HKCU\Software\Classes\SystemFileAssociations\.bat\shell\wincmd64_AddSchtasks\command\"\" /V execute') do set \"\"$$=%%1\"\" ^&^& cmd /D /C %%%%j)\",\"\",\"RunAs\",0))" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.bat\shell\wincmd64_AddSchtasks\command" /v execute /d "for /F \"Tokens=*\" %%i in (\"%%$$%%\") do (schtasks /Create /TN \"WithoutUAC %%~ni\" /TR \"mshta.exe VBScript:Close(CreateObject('Shell.Application').ShellExecute('%%~i','','','RunAs',0))\" /SC ONLOGON /F /RL HIGHEST)" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_AddSchtasks" /v "MUIVerb" /d "Add to Task Scheduler" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_AddSchtasks" /v "Icon" /d "shell32.dll,20" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_AddSchtasks" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_AddSchtasks" /v "Extended" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_AddSchtasks" /v "HasLUAShield" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_AddSchtasks\command" /ve /d "mshta.exe VBScript:Close(CreateObject(\"Shell.Application\").ShellExecute(\"cmd\",\"/D /C (for /F \"\"Tokens=2,*\"\" %%%%i in ('REG QUERY \"\"HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_AddSchtasks\command\"\" /V execute') do set \"\"$$=%%1\"\" ^&^& cmd /D /C %%%%j)\",\"\",\"RunAs\",0))" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_AddSchtasks\command" /v execute /d "for /F \"Tokens=*\" %%i in (\"%%$$%%\") do (schtasks /Create /TN \"WithoutUAC %%~ni\" /TR \"mshta.exe VBScript:Close(CreateObject('Shell.Application').ShellExecute('powershell.exe','-NoL -NoP -EP Bypass -File ''%%~i''','','RunAs',0))\" /SC ONLOGON /F /RL HIGHEST)" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\exefile\shell\wincmd64_AddSchtasks" /f
reg delete "HKCU\Software\Classes\SystemFileAssociations\.cmd\shell\wincmd64_AddSchtasks" /f
reg delete "HKCU\Software\Classes\SystemFileAssociations\.bat\shell\wincmd64_AddSchtasks" /f
reg delete "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_AddSchtasks" /f
color 27 & timeout 1
