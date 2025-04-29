:: Adds "Remind me!" entry to the Desktop context menu


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

reg add "HKCU\Software\Classes\DesktopBackground\shell\wincmd64_reminder" /v "MUIVerb" /d "Remind me!" /f
reg add "HKCU\Software\Classes\DesktopBackground\shell\wincmd64_reminder" /v "Icon" /d "shell32.dll,77" /f
reg add "HKCU\Software\Classes\DesktopBackground\shell\wincmd64_reminder" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\DesktopBackground\shell\wincmd64_reminder\command" /ve /d "powershell.exe -NoP -Ep Bypass -w Hidden -c Add-Type -AssemblyName Microsoft.VisualBasic; Add-Type -AssemblyName System.Windows.Forms; $t=[Microsoft.VisualBasic.Interaction]::InputBox('Enter reminder time (HH:mm):','Reminder Time'); if(-not $t){exit}; $m=[Microsoft.VisualBasic.Interaction]::InputBox('Enter reminder text:','Reminder Text'); if(-not $m){exit}; $d=Get-Date; $r=Get-Date ($d.ToString('yyyy-MM-dd')+' '+$t); if($r -le $d){[Windows.Forms.MessageBox]::Show('The specified time has already passed.','Error',0,16); exit}; Start-Sleep -Milliseconds (($r - (Get-Date)).TotalMilliseconds); [console]::beep(800,500); [console]::beep(1000,500); ($f=New-Object Windows.Forms.Form).TopMost=$true; [Windows.Forms.MessageBox]::Show($f,$m,'Reminder ('+$t+')',0,64)" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\DesktopBackground\shell\wincmd64_reminder" /f
color 27 & timeout 1
