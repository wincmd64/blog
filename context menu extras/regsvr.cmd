:: Adds "RegSvr" and "UnRegSvr" (hold Shift to activate) menu entries to the Explorer context menu
:: [area] .ocx .dll files


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

:: Register OLE controls

reg add "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_RegSvr" /v "MUIVerb" /d "RegSvr" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_RegSvr" /v "Icon" /d "shell32.dll,72" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_RegSvr" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_RegSvr" /v "NeverDefault" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_RegSvr\command" /ve /d "\"powershell.exe\" -WindowStyle Hidden -command \"start-process regsvr32 -ArgumentList '\\\"%%1\\\"' -verb RunAs\"" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_RegSvr" /v "MUIVerb" /d "RegSvr" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_RegSvr" /v "Icon" /d "shell32.dll,72" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_RegSvr" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_RegSvr" /v "NeverDefault" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_RegSvr\command" /ve /d "\"powershell.exe\" -WindowStyle Hidden -command \"start-process regsvr32 -ArgumentList '\\\"%%1\\\"' -verb RunAs\"" /f

:: UnRegister OLE controls

reg add "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_UnRegSvr" /v "MUIVerb" /d "UnRegSvr" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_UnRegSvr" /v "Icon" /d "shell32.dll,72" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_UnRegSvr" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_UnRegSvr" /v "Extended" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_UnRegSvr\command" /ve /d "\"powershell.exe\" -WindowStyle Hidden -command \"start-process regsvr32 -ArgumentList '/u \\\"%%1\\\"' -verb RunAs\"" /f

reg add "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_UnRegSvr" /v "MUIVerb" /d "UnRegSvr" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_UnRegSvr" /v "Icon" /d "shell32.dll,72" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_UnRegSvr" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_UnRegSvr" /v "Extended" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_UnRegSvr\command" /ve /d "\"powershell.exe\" -WindowStyle Hidden -command \"start-process regsvr32 -ArgumentList '/u \\\"%%1\\\"' -verb RunAs\"" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_RegSvr" /f
reg delete "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_RegSvr" /f
reg delete "HKCU\Software\Classes\SystemFileAssociations\.ocx\shell\wincmd64_UnRegSvr" /f
reg delete "HKCU\Software\Classes\SystemFileAssociations\.dll\shell\wincmd64_UnRegSvr" /f
color 27 & timeout 1
