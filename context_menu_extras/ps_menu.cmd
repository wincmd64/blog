:: Adds "Run bypass" and "Execution Policy" menu entries to the Explorer context menu
:: [area] .ps1 files


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

:: Run bypass

reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun" /v "MUIVerb" /d "Run bypass" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun" /v "SubCommands" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun\shell\01u" /v "MUIVerb" /d "NoExit" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun\shell\01u" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun\shell\01u\command" /ve /d "powershell.exe -NoExit -ExecutionPolicy Bypass -File \"%%1\"" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun\shell\02a" /v "MUIVerb" /d "Admin" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun\shell\02a" /v "Icon" /d "powershell.exe,1" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun\shell\02a\command" /ve /d "powershell.exe -Command \"Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File \\\"%%1\\\"' -Verb RunAs\"" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun\shell\03a" /v "MUIVerb" /d "Admin NoExit" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun\shell\03a" /v "Icon" /d "powershell.exe,1" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun\shell\03a\command" /ve /d "powershell.exe -Command \"Start-Process powershell.exe -ArgumentList '-NoExit -ExecutionPolicy Bypass -File \\\"%%1\\\"' -Verb RunAs\"" /f

:: ExecutionPolicy

reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol" /v "MUIVerb" /d "Execution Policy" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol" /v "SubCommands" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol\shell\01get" /v "MUIVerb" /d "Get Current" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol\shell\01get" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol\shell\01get\command" /ve /d "powershell.exe -NoExit -Command \"write-host 'Current execution policy: ' -NoNewline; Get-ExecutionPolicy ^| write-host -ForegroundColor Yellow; ^''\"" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol\shell\02set" /v "MUIVerb" /d "Set RemoteSigned" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol\shell\02set" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol\shell\02set\command" /ve /d "powershell.exe -NoExit -Command \"Set-ExecutionPolicy RemoteSigned -Scope CurrentUser; write-host 'Set as default: ' -NoNewline; Get-ExecutionPolicy ^| write-host -ForegroundColor Green; ^''\"" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol\shell\03set" /v "MUIVerb" /d "Set Restricted" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol\shell\03set" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol\shell\03set\command" /ve /d "powershell.exe -NoExit -Command \"Set-ExecutionPolicy Restricted -Scope CurrentUser; write-host 'Set as default: ' -NoNewline; Get-ExecutionPolicy ^| write-host -ForegroundColor Red; ^''\"" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSrun" /f
reg delete "HKCU\Software\Classes\SystemFileAssociations\.ps1\shell\wincmd64_PSexecpol" /f
color 27 & timeout 1
