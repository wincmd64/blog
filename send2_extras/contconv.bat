:: Wrapper for ContConv CLI — contact (.vcf) convertor
:: by github.com/wincmd64

:: Usage:
:: Create a shortcut to this .bat file in the Shell:SendTo folder
:: or button in TotalCmd with the %P%S parameter

@echo off
for /f "tokens=* delims=" %%a in ('where contconv.exe 2^>nul') do set "app=%%a"
if not exist "%app%" (echo. & echo  "contconv.exe" not found. & echo  Download it from: https://github.com/DarkHobbit/doublecontact/releases & echo. & pause & exit) else (TITLE %app%)

set count=0
for %%A in (%*) do set /a count+=1
if %count% equ 0 (echo. & echo  No objects selected & echo. & pause & exit)
if %count% equ 1 (echo. & echo  Processing: %* & echo.) else (echo. & echo  Processing %count% objects. & echo.)
if /I not "%~x1"==".vcf" echo  NOTICE: extension is not .VCF & echo.

echo  1 = convert to HTML
echo  2 = convert to CSV
echo. 
CHOICE /C 12 /M "Your choice?:" >nul 2>&1
if errorlevel 2 goto Option_2
if errorlevel 1 goto Option_1

:Option_1
FOR %%k IN (%*) DO (echo. & "%app%" -i "%%~k" -o "%%~dpnk.htm" -f html -w)
echo. & echo. & echo  DONE. & echo. & pause & exit
:Option_2
FOR %%k IN (%*) DO (echo. & "%app%" -i "%%~k" -o "%%~dpnk.csv" -f csv -op generic -w)
echo. & echo. & echo  DONE. & echo. & pause & exit

