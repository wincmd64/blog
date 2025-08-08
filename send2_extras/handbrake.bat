:: Wrapper for HandBrake CLI — convert video using presets
:: by github.com/wincmd64

:: Usage:
:: Create a shortcut to this .bat file in the Shell:SendTo folder
:: or button in TotalCmd with the %P%S parameter

:: List of presets: https://handbrake.fr/docs/en/latest/technical/official-presets.html

@echo off
for /f "tokens=* delims=" %%a in ('where HandBrakeCLI.exe 2^>nul') do set "app=%%a"
if not exist "%app%" (echo. & echo  "HandBrakeCLI.exe" not found. & echo  Try: winget install HandBrake.HandBrake.CLI & echo. & pause & exit) else (TITLE %app%)

set count=0
for %%A in (%*) do set /a count+=1
if %count% equ 0 (echo. & echo  No objects selected & echo. & pause & exit)
if %count% equ 1 (echo. & echo  Processing: %* & echo.) else (echo. & echo  Processing %count% objects. & echo.)
if "%~x1"=="" echo  NOTICE: first argument is likely a folder or has no extension. & echo.

SET /p preset= Enter HandBrake preset name or press Enter for default (Fast 1080p30): 
if "%preset%"=="" (SET preset=Fast 1080p30)
TITLE %preset%

FOR %%k IN (%*) DO (
    echo. & echo FILE: %%k
    "%app%" -v0 -Z "%preset%" -E copy -i "%%~k" -o "%%~dpnk_%preset%.mp4"
    FOR /f "tokens=1-5 delims=.-/: " %%m IN ("%%~tk") DO (
        powershell "Get-ChildItem '%%~dpnk_%preset%.mp4' | ForEach-Object{$_.CreationTime = $_.LastWriteTime = $_.LastAccessTime = New-Object DateTime %%o,%%n,%%m,%%p,%%q,00}"
    )
)
color 27 & timeout 2
