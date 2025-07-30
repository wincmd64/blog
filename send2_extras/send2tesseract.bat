:: Tesseract OCR
:: by t.me/wincmd64

:: Usage:
:: Create a shortcut to this .bat file in the Shell:SendTo folder
:: or button in TotalCmd with the %P%S parameter

:: Command line arguments:
:: /s - create shortcut in Shell:SendTo folder

:: Note: this file must use code page OEM 866

@echo off
setlocal

:: path to tesseract.exe -- custom if nedded
set "myapp="
if defined myapp if exist "%myapp%" (set "app=%myapp%") 
:: path to tesseract.exe -- from PATH or same folder
if not defined app (for /f "tokens=* delims=" %%a in ('where tesseract.exe 2^>nul') do set "app=%%a")
:: path to tesseract.exe -- from registry
if not defined app (for /f "tokens=3*" %%a in ('reg query "HKLM\SOFTWARE\Tesseract-OCR" /v Path 2^>nul') do set "tesspath=%%a%%b")
if defined tesspath set "app=%tesspath%\tesseract.exe"
:: path to tesseract.exe -- fallback, manual download
if not exist "%app%" (color 4 & echo. & echo  tesseract.exe not found. Try download from: https://github.com/UB-Mannheim/tesseract/wiki & echo. & pause & exit) else (TITLE %app%)

:: arguments
if /i "%~1"=="/s" (if "%~2"=="" goto :shortcut)

set layout=single
set lang=ukr+rus
set ext=pdf
:main
chcp 866 >nul
cls
echo.
echo  ████████╗███████╗███████╗███████╗███████╗██████╗  █████╗  ██████╗████████╗
echo  ╚══██╔══╝██╔════╝██╔════╝██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝╚══██╔══╝
echo     ██║   █████╗  ███████╗███████╗█████╗  ██████╔╝███████║██║        ██║   
echo     ██║   ██╔══╝  ╚════██║╚════██║██╔══╝  ██╔══██╗██╔══██║██║        ██║   
echo     ██║   ███████╗███████║███████║███████╗██║  ██║██║  ██║╚██████╗   ██║   
echo     ╚═╝   ╚══════╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   
echo.
chcp 1251 >nul
:: checking the number of selected files
set count=0
for %%A in (%*) do set /a count+=1
if %count% equ 0 (echo  No files selected & echo. & pause & exit)

if %count% equ 1 (echo  Processing: %* & echo.) else (echo  Processing: %count% files & echo.)
if "%~x1"=="" echo  NOTICE: first argument is likely a folder or has no extension. & echo.
echo  Options:
echo  1 = layout: as %layout% file
echo  2 = specify language(s) used for OCR: %lang%
echo  3 = output: %ext%
echo.
echo  Enter = start OCR
echo.
set userchoice=
set /p userchoice=^> 
if "%userchoice%"=="1" echo. & goto Option_1
if "%userchoice%"=="2" echo. & goto Option_2
if "%userchoice%"=="3" echo. & goto Option_3
if "%userchoice%"==""  echo. & goto start
exit

:Option_1
if %count% equ 1 (echo  Only 1 file is selected - nothing to merge & echo. & pause & goto main)
if "%layout%"=="single" (set "layout=multiple") else if "%layout%"=="multiple" (set "layout=single") else (set "layout=single")
goto main

:Option_2
"%app%" --list-langs
echo.
set /p lang=Enter language(s) (LANG[+LANG]): 
goto main

:Option_3
set /p ext=Enter output format (pdf, txt, ...): 
goto main

:start
set "err="
if "%layout%"=="multiple" (
    FOR %%k IN (%*) DO (
        echo  FILE: "%%~k"
        "%app%" "%%~k" "%%~dpnk_%lang%" -l %lang% %ext%
        if errorlevel 1 set "err=1"
    )
    if defined err (color 4 & pause) else (color 27 & timeout 2)
) else (
    pushd "%~dp1"
    (
        for %%i in (%*) do @echo %%~fi
    ) > "listfile.txt"
    "%app%" "listfile.txt" "%~dpn1_%lang%" -l %lang% %ext%
    if errorlevel 1 (color 4 & pause) else (color 27 & timeout 2)
    del listfile.txt
)
exit

:shortcut
powershell -NoP -NoL -Ep Bypass -c ^
"$s = (New-Object -ComObject WScript.Shell).CreateShortcut([Environment]::GetFolderPath('SendTo') + '\Tesseract OCR.lnk'); ^
$s.TargetPath = '%~f0'; $s.IconLocation = 'shell32.dll,55'; $s.Save()"
echo. & echo  Shortcut 'Tesseract OCR.lnk' created. & echo. & pause & exit
