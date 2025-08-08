:: Wrapper for InnoUnp CLI — Inno Setup unpacker
:: by github.com/wincmd64

:: Usage:
:: Create a shortcut to this .bat file in the Shell:SendTo folder
:: or button in TotalCmd with the %P%S parameter

@echo off
for /f "tokens=* delims=" %%a in ('where innounp.exe 2^>nul') do set "app=%%a"
if not exist "%app%" (echo. & echo  "innounp.exe" not found. & echo  Download it from: https://www.rathlev-home.de/tools/download/innounp-2.zip & echo. & pause & exit) else (TITLE %app%)

set count=0
for %%A in (%*) do set /a count+=1
if %count% equ 0 (echo. & echo  No objects selected & echo. & pause & exit)
if %count% equ 1 (echo. & echo  Processing: %* & echo. & pause) else (echo. & echo  Processing %count% objects. & echo. & pause)

FOR %%k IN (%*) DO (echo. & "%app%" -x -d"%%~dpnk_unpacked" "%%~k")
echo. & echo. & echo  DONE. & echo. & pause
