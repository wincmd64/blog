:: Wrapper for HandBrake CLI — convert video using presets
:: by github.com/wincmd64

:: Usage:
:: Create a shortcut to this .bat file in the Shell:SendTo folder
:: or button in TotalCmd with the %P%S parameter

@echo off
for /f "tokens=* delims=" %%a in ('where HandBrakeCLI.exe 2^>nul') do set "app=%%a"
if not exist "%app%" (echo. & echo  "HandBrakeCLI.exe" not found. & echo  Try: winget install HandBrake.HandBrake.CLI & echo. & pause & exit) else (TITLE %app%)

:: arguments
if "%~1"=="/s" (if "%~2"=="" goto :shortcut)

set count=0
for %%A in (%*) do set /a count+=1
if %count% equ 0 (echo. & echo  No objects selected & echo. & pause & exit)
if %count% equ 1 (echo. & echo  Processing: %* & echo.) else (echo. & echo  Processing %count% objects. & echo.)
if "%~x1"=="" echo  NOTICE: first argument is likely a folder or has no extension. & echo.

echo   Full list of presets: https://handbrake.fr/docs/en/latest/technical/official-presets.html
echo   Some examples: "Very Fast 1080p30", "Super HQ 1080p30 Surround", "Fast 1080p30" (default) & echo.

SET /p preset= Enter HandBrake preset name or press Enter for default: 
if "%preset%"=="" (SET preset=Fast 1080p30)
TITLE %preset%

FOR %%k IN (%*) DO (
    echo. & echo FILE: %%k
    "%app%" -v0 -Z "%preset%" -E copy -i "%%~k" -o "%%~dpnk_%preset%.mp4"
    FOR /f "tokens=1-5 delims=.-/: " %%m IN ("%%~tk") DO (
        powershell "Get-ChildItem '%%~dpnk_%preset%.mp4' | ForEach-Object{$_.CreationTime = $_.LastWriteTime = $_.LastAccessTime = New-Object DateTime %%o,%%n,%%m,%%p,%%q,00}"
    )
)
color 27 & timeout 2 & exit

:shortcut
powershell -NoP -NoL -Ep Bypass -c ^
"$s = (New-Object -ComObject WScript.Shell).CreateShortcut([Environment]::GetFolderPath('SendTo') + '\HandBrake.lnk'); ^
$s.TargetPath = '%~f0'; $s.IconLocation = 'dfrgui.exe'; $s.Save()"
echo. & echo  Shortcut 'HandBrake.lnk' created. & echo. & pause & exit