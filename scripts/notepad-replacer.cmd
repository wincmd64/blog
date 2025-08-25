:: Replacing default notepad.exe with your editor
:: by t.me/wincmd64

@echo off
(Net session >nul 2>&1)&&(cd /d "%~dp0")||(PowerShell start """%~0""" -verb RunAs & Exit /B)
:: path to your editor
SET "NOTEPAD_PATH=%ProgramFiles%\Notepad++\notepad++.exe"
if exist "%NOTEPAD_PATH%" (echo. & echo  Set "%NOTEPAD_PATH%" as default editor? & echo. & pause) else (echo. & echo  Path to your editor does not found. & echo. & exit)

:: use "\"%NOTEPAD_PATH%\" /z" for AkelPad
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /v "Debugger" /t REG_SZ /d "\"%NOTEPAD_PATH%\" -notepadStyleCmdline -z" /f

:: check if win11
for /f %%a in ('powershell.exe -NoP -NoL -NonI -EP Bp -c "(gwmi Win32_OperatingSystem).Caption -Replace '\D'"') do (
   if "%%a"=="11" goto 11
)
echo. & echo  Done. & echo. & pause & exit

:11
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe\0" /v "FilterFullPath" /t REG_SZ /d "%NOTEPAD_PATH%" /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe\1" /v "FilterFullPath" /t REG_SZ /d "%NOTEPAD_PATH%" /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe\2" /v "FilterFullPath" /t REG_SZ /d "%NOTEPAD_PATH%" /f
powershell -Command "Get-AppxPackage *Microsoft.WindowsNotepad* | Remove-AppxPackage"
echo. & echo  Done. & echo. & pause & exit
