:: Adds "Hash" menu entry to the Explorer context menu (hold Shift to activate)
:: [area] all files


@ECHO OFF
:: Use /u to undo changes
if /i "%1"=="/u" goto undo

reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash" /v "MUIVerb" /d "Hash" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash" /v "Icon" /d "gpedit.dll" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash" /v "Extended" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash" /v "SubCommands" /f

reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\01_SHA1" /v "MUIVerb" /d "SHA1" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\01_SHA1" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\01_SHA1\command" /ve /d "powershell -noexit get-filehash -literalpath \\\"%%1\\\" -algorithm SHA1 | format-list" /f

reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\02_SHA256" /v "MUIVerb" /d "SHA256" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\02_SHA256" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\02_SHA256\command" /ve /d "powershell -noexit get-filehash -literalpath \\\"%%1\\\" -algorithm SHA256 | format-list" /f

reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\03_SHA384" /v "MUIVerb" /d "SHA384" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\03_SHA384" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\03_SHA384\command" /ve /d "powershell -noexit get-filehash -literalpath \\\"%%1\\\" -algorithm SHA384 | format-list" /f

reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\04_SHA512" /v "MUIVerb" /d "SHA512" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\04_SHA512" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\04_SHA512\command" /ve /d "powershell -noexit get-filehash -literalpath \\\"%%1\\\" -algorithm SHA512 | format-list" /f

reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\05_MD5" /v "MUIVerb" /d "MD5" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\05_MD5" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\05_MD5\command" /ve /d "powershell -noexit get-filehash -literalpath \\\"%%1\\\" -algorithm MD5 | format-list" /f

reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\06_All" /v "MUIVerb" /d "Show all" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\06_All" /v "Icon" /d "powershell.exe" /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\06_All" /v "CommandFlags" /t REG_DWORD /d 32 /f
reg add "HKCU\Software\Classes\*\shell\wincmd64_Hash\shell\06_All\command" /ve /d "powershell -noexit get-filehash -literalpath \\\"%%1\\\" -algorithm SHA1 | format-list;get-filehash -literalpath \\\"%%1\\\" -algorithm SHA256 | format-list;get-filehash -literalpath \\\"%%1\\\" -algorithm SHA384 | format-list;get-filehash -literalpath \\\"%%1\\\" -algorithm SHA512 | format-list;get-filehash -literalpath \\\"%%1\\\" -algorithm MD5 | format-list" /f

color 27 & timeout 1 & exit

:undo
reg delete "HKCU\Software\Classes\*\shell\wincmd64_Hash" /f
color 27 & timeout 1
