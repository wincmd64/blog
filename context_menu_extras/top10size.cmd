:: Adds "Top 10 by Size" entry to the Explorer context menu (hold Shift to activate)
:: [area] dirs, drives


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

reg add "HKCU\Software\Classes\Directory\shell\wincmd64_Top10size" /v "MUIVerb" /d "Top 10 by Size" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_Top10size" /v "Icon" /d "shell32.dll,133" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_Top10size" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_Top10size" /v "Extended" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_Top10size\command" /ve /d "powershell.exe -NoP -Ep Bypass -c (Write-Host 'Calculating...'); $files=Get-ChildItem -Path '%%V' -File -Force -EA 0 | Select FullName,@{n='Size';e={$_.Length}}; $dirs=Get-ChildItem -Path '%%V' -Directory -Force -EA 0 | ForEach { $_ | Add-Member Size ((Get-ChildItem $_.FullName -Recurse -File -Force -EA 0 | Measure-Object Length -Sum).Sum) -PassThru } | Select FullName,Size; $all=$files+$dirs; Clear-Host; $all | Sort Size -Desc | Select -First 10 @{n='Path';e={ if ($_.FullName.Length -gt 100) { $_.FullName.Substring(0,100) + '...' } else { $_.FullName } }}, @{n='Size (MB)';e={'{0:N2}' -f ($_.Size/1MB)}} | Format-Table -AutoSize | Out-Host; pause" /f

reg add "HKCU\Software\Classes\Drive\shell\wincmd64_Top10size" /v "MUIVerb" /d "Top 10 by Size" /f
reg add "HKCU\Software\Classes\Drive\shell\wincmd64_Top10size" /v "Icon" /d "shell32.dll,133" /f
reg add "HKCU\Software\Classes\Drive\shell\wincmd64_Top10size" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\Drive\shell\wincmd64_Top10size" /v "Extended" /f
reg add "HKCU\Software\Classes\Drive\shell\wincmd64_Top10size\command" /ve /d "powershell.exe -NoP -Ep Bypass -c (Write-Host 'Calculating...'); $files=Get-ChildItem -Path '%%V' -File -Force -EA 0 | Select FullName,@{n='Size';e={$_.Length}}; $dirs=Get-ChildItem -Path '%%V' -Directory -Force -EA 0 | ForEach { $_ | Add-Member Size ((Get-ChildItem $_.FullName -Recurse -File -Force -EA 0 | Measure-Object Length -Sum).Sum) -PassThru } | Select FullName,Size; $all=$files+$dirs; Clear-Host; $all | Sort Size -Desc | Select -First 10 @{n='Path';e={ if ($_.FullName.Length -gt 100) { $_.FullName.Substring(0,100) + '...' } else { $_.FullName } }}, @{n='Size (MB)';e={'{0:N2}' -f ($_.Size/1MB)}} | Format-Table -AutoSize | Out-Host; pause" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\Directory\shell\wincmd64_Top10size" /f
reg delete "HKCU\Software\Classes\Drive\shell\wincmd64_Top10size" /f
color 27 & timeout 1
