:: Wrapper for SDelete — secure delete utility
:: by github.com/wincmd64

:: Usage:
:: Create a shortcut to this .bat file in the Shell:SendTo folder
:: or button in TotalCmd with the %P%S parameter

@echo off
for /f "tokens=* delims=" %%a in ('where sdelete64.exe 2^>nul') do set "app=%%a"
if not exist "%app%" (
    echo. & echo  "sdelete64.exe" not found. & echo  Try to download it to "%~dp0" ? & echo. & pause
    curl.exe --ssl-no-revoke -RO# "https://live.sysinternals.com/sdelete64.exe"
    if errorlevel 1 (echo. & echo  Download failed. Try manually: https://learn.microsoft.com/sysinternals/downloads/sdelete & echo. & pause & exit) else (echo. & echo  DONE. Please re-run this script. & echo. & pause & exit)
) else (TITLE %app%)

set count=0
for %%A in (%*) do set /a count+=1
if %count% equ 0 (echo. & echo  No objects selected & echo. & pause & exit)
if %count% equ 1 (echo. & echo  Delete %* ? & echo. & pause) else (echo. & echo  Delete %count% objects? & echo. & pause)

FOR %%k IN (%*) DO (echo. & "%app%" -nobanner -s "%%~k")
echo. & echo. & echo  DONE. & echo. & pause
