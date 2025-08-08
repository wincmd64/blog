:: Adds "Firewall" menu entry to the Explorer context menu (hold Shift to activate)
:: [area] .exe files


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall" /v "MUIVerb" /d "Firewall" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall" /v "Icon" /d "%%ProgramFiles%%\Windows Defender\EppManifest.dll,4" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall" /v "Extended" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall" /v "SubCommands" /f

reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall\shell\01block" /v "MUIVerb" /d "Block" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall\shell\01block" /v "Icon" /d "imageres.dll,100" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall\shell\01block\command" /ve /d "powershell -WindowStyle Hidden -Command \"start powershell -Verb runas -ArgumentList \\\"-NoLogo -WindowStyle Hidden -command `\\\"New-NetFirewallRule -DisplayName ([System.IO.Path]::GetFilenameWithoutExtension('%%1')) -Name '%%1' -Enabled True -Direction Outbound -Action Block -Program '%%1'`\\\"\\\"\"" /f

reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall\shell\02allow" /v "MUIVerb" /d "Allow" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall\shell\02allow" /v "Icon" /d "imageres.dll,101" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall\shell\02allow\command" /ve /d "powershell -WindowStyle Hidden -Command \"start powershell -Verb runas -ArgumentList \\\"-NoLogo -WindowStyle Hidden -command `\\\"Remove-NetFirewallRule -Name '%%1'`\\\"\\\"\"" /f

reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall\shell\03rules" /v "MUIVerb" /d "Open Control panel" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall\shell\03rules" /v "Icon" /d "FirewallControlPanel.dll" /f
reg add "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall\shell\03rules\command" /ve /d "mmc WF.msc" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\exefile\shell\wincmd64_Firewall" /f
color 27 & timeout 1
