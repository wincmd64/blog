:: Adds "View content" entry to the Explorer context menu
:: /!\ REQUIRES /!\  Run this in PowerShell once: Install-Module -Name GPRegistryPolicyParser
:: [area] .pol files


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

reg add "HKCU\Software\Classes\SystemFileAssociations\.pol\shell\wincmd64_pol" /v "MUIVerb" /d "View content" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.pol\shell\wincmd64_pol" /v "Icon" /d "powershell_ise.exe,1" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.pol\shell\wincmd64_pol" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\SystemFileAssociations\.pol\shell\wincmd64_pol\command" /ve /d "powershell.exe -NoP -w Hidden -Ep Bypass -c \"Import-Module GPRegistryPolicyParser -Wa Ignore; Read-PolFile -Path \\\"%%1\\\" ^| Out-GridView -Title \\\"Registry.Pol Content [%%1]\\\" -Wait\"" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\SystemFileAssociations\.pol\shell\wincmd64_pol" /f
color 27 & timeout 1
