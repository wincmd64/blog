:: Adds "Take Ownership" entry to the Explorer context menu (hold Shift to activate)
:: Converted from: https://www.tenforums.com/tutorials/3841-add-take-ownership-context-menu-windows-10-a.html
:: [area] all files, dirs and drives


@echo off
set "PowerShell=powershell.exe -NoP -NoL -Ep Bp -w Hidden -w Minimized -c"
set "File=HKCU\Software\Classes\*\shell\TakeOwnership"
set "Directory=HKCU\Software\Classes\Directory\shell\TakeOwnership"
set "Drive=HKCU\Software\Classes\Drive\shell\TakeOwnership"
:: Use /u to undo changes
if /i "%1"=="/u" goto undo
 
:: Take Ownership for <File>
reg DELETE "%File%" /f >nul 2>&1
reg ADD "%File%" /v "" /t REG_SZ /d "Take Ownership" /f
reg ADD "%File%" /v "Extended" /t REG_SZ /d "" /f
reg ADD "%File%" /v "HasLUAShield" /t REG_SZ /d "" /f
reg ADD "%File%" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
reg ADD "%File%" /v "Position" /t REG_SZ /d "Middle" /f
reg ADD "%File%" /v "NeverDefault" /t REG_SZ /d "" /f
reg ADD "%File%\command" /v "" /t REG_SZ /d "%PowerShell% \"Start-Process -FilePath 'cmd.exe' -ArgumentList '/c takeown /F \\\"%%1\\\" ^&^& icacls \\\"%%1\\\" /grant *S-1-3-4:F /T /C /L /Q' -WindowStyle Hidden -Verb RunAs\"" /f
reg ADD "%File%\command" /v "IsolatedCommand" /t REG_SZ /d "%PowerShell% \"Start-Process -FilePath 'cmd.exe' -ArgumentList '/c takeown /F \\\"%%1\\\" ^&^& icacls \\\"%%1\\\" /grant *S-1-3-4:F /T /C /L /Q' -WindowStyle Hidden -Verb RunAs\"" /f
 
:: Take Ownership for <Directory>
reg DELETE "%Directory%" /f >nul 2>&1
reg ADD "%Directory%" /v "" /t REG_SZ /d "Take Ownership" /f
reg ADD "%Directory%" /v "AppliesTo" /t REG_SZ /d "NOT (System.ItemPathDisplay:=\"%SystemDrive%\Users\" OR System.ItemPathDisplay:=\"%SystemDrive%\Пользователи\" OR System.ItemPathDisplay:=\"%ProgramData%\" OR System.ItemPathDisplay:=\"%SystemRoot%\" OR System.ItemPathDisplay:=\"%SystemRoot%\System32\" OR System.ItemPathDisplay:=\"%ProgramW6432%\" OR System.ItemPathDisplay:=\"%ProgramFiles(x86)%\")" /f
reg ADD "%Directory%" /v "Extended" /t REG_SZ /d "" /f
reg ADD "%Directory%" /v "HasLUAShield" /t REG_SZ /d "" /f
reg ADD "%Directory%" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
reg ADD "%Directory%" /v "Position" /t REG_SZ /d "Middle" /f
reg ADD "%Directory%\command" /v "" /t REG_SZ /d "%PowerShell% \"Start-Process -FilePath 'cmd.exe' -ArgumentList ('/c takeown /F \\\"%%1\\\" /R /D Y ^&^& icacls \\\"%%1\\\" /grant *S-1-3-4:F /T /C /L /Q') -WindowStyle Hidden -Verb RunAs\"" /f
reg ADD "%Directory%\command" /v "IsolatedCommand" /t REG_SZ /d "%PowerShell% \"Start-Process -FilePath 'cmd.exe' -ArgumentList ('/c takeown /F \\\"%%1\\\" /R /D Y ^&^& icacls \\\"%%1\\\" /grant *S-1-3-4:F /T /C /L /Q') -WindowStyle Hidden -Verb RunAs\"" /f
 
:: Take Ownership for <Drive>
reg DELETE "%Drive%" /f >nul 2>&1
reg ADD "%Drive%" /v "" /t REG_SZ /d "Take Ownership" /f
reg ADD "%Drive%" /v "AppliesTo" /t REG_SZ /d "NOT (System.ItemPathDisplay:=\"%SystemDrive%\\\")" /f
reg ADD "%Drive%" /v "Extended" /t REG_SZ /d "" /f
reg ADD "%Drive%" /v "HasLUAShield" /t REG_SZ /d "" /f
reg ADD "%Drive%" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
reg ADD "%Drive%" /v "Position" /t REG_SZ /d "Middle" /f
reg ADD "%Drive%\command" /v "" /t REG_SZ /d "%PowerShell% \"Start-Process -FilePath 'cmd.exe' -ArgumentList '/c takeown /F \\\"%%1\\\\\" /R /D Y ^&^& icacls \\\"%%1\\\\\" /grant *S-1-3-4:F /T /C /Q' -WindowStyle Hidden -Verb RunAs\"" /f
reg ADD "%Drive%\command" /v "IsolatedCommand" /t REG_SZ /d "%PowerShell% \"Start-Process -FilePath 'cmd.exe' -ArgumentList '/c takeown /F \\\"%%1\\\\\" /R /D Y ^&^& icacls \\\"%%1\\\\\" /grant *S-1-3-4:F /T /C /Q' -WindowStyle Hidden -Verb RunAs\"" /f

color 27 & timeout 1 & exit

:undo
reg DELETE "%File%" /f
reg DELETE "%Directory%"  /f
reg DELETE "%Drive%" /f
color 27 & timeout 1
