:: Wrapper for Caesium CLI — image compression utility
:: by github.com/wincmd64

:: Usage:
:: Create a shortcut to this .bat file in the Shell:SendTo folder
:: or button in TotalCmd with the %P%S parameter

@echo off
for /f "tokens=* delims=" %%a in ('where caesiumclt.exe 2^>nul') do set "app=%%a"
if not exist "%app%" (echo. & echo  "caesiumclt.exe" not found. & echo  Download it from: https://github.com/Lymphatus/caesium-clt & echo. & pause & exit) else (TITLE %app%)

set count=0
for %%A in (%*) do set /a count+=1
if %count% equ 0 (echo. & echo  No objects selected & echo. & pause & exit)
if %count% equ 1 (echo. & echo  Processing: %* & echo. & pause) else (echo. & echo  Processing %count% objects. & echo. & pause)

FOR %%k IN (%*) DO (echo. & "%app%" --lossless --exif --keep-dates --same-folder-as-input --overwrite bigger "%%~k")
echo. & echo. & echo  DONE. & echo. & pause
