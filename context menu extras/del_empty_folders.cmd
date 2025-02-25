:: Adds "Delete empty folders (recursively)" menu entry to the Explorer context menu (hold Shift to activate)
:: [area] dirs


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DelEmptyDirs" /v "MUIVerb" /d "Delete empty folders (recursively)" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DelEmptyDirs" /v "Icon" /d "imageres.dll,7" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DelEmptyDirs" /v "Position" /d "Bottom" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DelEmptyDirs" /v "Extended" /f
reg add "HKCU\Software\Classes\Directory\shell\wincmd64_DelEmptyDirs\command" /ve /d "cmd.exe /K for /f \"usebackq delims=\" %%%%d in (`\"dir \"%%V\" /ad/b/s ^| sort /R\"`) do rd \"%%%%~d\"" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\Directory\shell\wincmd64_DelEmptyDirs" /f
color 27 & timeout 1
