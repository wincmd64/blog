:: IrfanView converter
:: by t.me/wincmd64

:: Usage:
:: Create a shortcut to this .bat file in the Shell:SendTo folder
:: or button in TotalCmd with the %P%S parameter

:: Command line arguments:
:: /s - create shortcut in Shell:SendTo folder
:: /a - associate image files with IrfanView (SetUserFTA.exe required)

:: Note: this file must use code page OEM 866

@echo off
setlocal

:: path to i_view64.exe - custom if nedded
set "myapp="
if defined myapp if exist "%myapp%" (set "app=%myapp%") 
:: path to i_view64.exe - from PATH or same folder
if not defined app (for /f "tokens=* delims=" %%a in ('where i_view64.exe 2^>nul') do set "app=%%a")
if not exist "%app%" (color 4 & echo. & echo  i_view64.exe not found. Try: winget install IrfanSkiljan.IrfanView & echo. & pause & exit) else (TITLE %app%)

:: arguments
if /i "%~1"=="/s" (if "%~2"=="" goto :shortcut)
if /i "%~1"=="/a" (if "%~2"=="" goto :associate)

echo.
echo  ██╗██████╗ ███████╗ █████╗ ███╗   ██╗██╗   ██╗██╗███████╗██╗    ██╗
echo  ██║██╔══██╗██╔════╝██╔══██╗████╗  ██║██║   ██║██║██╔════╝██║    ██║
echo  ██║██████╔╝█████╗  ███████║██╔██╗ ██║██║   ██║██║█████╗  ██║ █╗ ██║
echo  ██║██╔══██╗██╔══╝  ██╔══██║██║╚██╗██║╚██╗ ██╔╝██║██╔══╝  ██║███╗██║
echo  ██║██║  ██║██║     ██║  ██║██║ ╚████║ ╚████╔╝ ██║███████╗╚███╔███╔╝
echo  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚══════╝ ╚══╝╚══╝ 
echo.
chcp 1251 >nul
:: checking the number of selected files
set count=0
for %%A in (%*) do set /a count+=1

if %count% equ 0 (echo  No files selected & echo. & pause & exit)

if %count% equ 1 (echo  Processing: %* & echo.) else (echo  Processing: %count% files & echo.)
echo  1 = resize image by 50%%
echo  2 = blur effect
echo  3 = horizontal panorama
echo  4 = vertical panorama
echo  5 = convert to .ext
echo  6 = create multipage PDF from input files
echo  7 = extract all pages from a multipage file to .ext
echo  8 = jpg lossless rotate
echo  9 = set as wallpaper
echo.
CHOICE /C "123456789" /M "Your choice?:" >nul 2>&1
if errorlevel 9 goto Option_9
if errorlevel 8 goto Option_8
if errorlevel 7 goto Option_7
if errorlevel 6 goto Option_6
if errorlevel 5 goto Option_5
if errorlevel 4 goto Option_4
if errorlevel 3 goto Option_3
if errorlevel 2 goto Option_2
if errorlevel 1 goto Option_1
exit

:Option_1
FOR %%k IN (%*) DO (
    echo  FILE: "%%~k"
    "%app%" "%%~k" /resize=^(50p,50p^) /resample /convert="%%~dpnk_resized%%~xk"
)
color 27 & timeout 2 & exit
:Option_2
FOR %%k IN (%*) DO (
    echo  FILE: "%%~k"
    "%app%" "%%~k" /effect=^(2,6^) /resample /convert="%%~dpnk_blurred%%~xk"
)
color 27 & timeout 2 & exit
:Option_3
for %%F in (%1) do pushd "%%~dpF"
(
    for %%i in (%*) do @echo %%~fi
) > "listfile.txt"
"%app%" /panorama=(1,filelist="listfile.txt")
del listfile.txt
color 27 & timeout 2 & exit
:Option_4
for %%F in (%1) do pushd "%%~dpF"
(
    for %%i in (%*) do @echo %%~fi
) > "listfile.txt"
"%app%" /panorama=(2,filelist="listfile.txt")
del listfile.txt
color 27 & timeout 2 & exit
:Option_5
set /p ext=Enter extention (png jpg bmp gif ico ... all supported: https://irfanview.com/main_formats.htm ): 
FOR %%k IN (%*) DO (
    echo  FILE: "%%~k"
    "%app%" "%%~k" /resample /convert="%%~dpnk.%ext%" /makecopy
)
color 27 & timeout 2 & exit
:Option_6
for %%F in (%1) do pushd "%%~dpF"
(
    for %%i in (%*) do @echo %%~fi
) > "listfile.txt"
"%app%" /multipdf=(%~n1.pdf,filelist="listfile.txt") /killmesoftly
del listfile.txt
color 27 & timeout 2 & exit
:Option_7
set /p ext=Enter extention (png jpg bmp gif ico ... all supported: https://irfanview.com/main_formats.htm ): 
FOR %%k IN (%*) DO (
    echo  FILE: "%%~k"
    "%app%" "%%~k" /extract=^(.,%ext%^) /killmesoftly
)
color 27 & timeout 2 & exit
:Option_8
for %%F in (%1) do pushd "%%~dpF"
(
    for %%i in (%*) do @echo %%~fi
) > "listfile.txt"
echo  1 = flip vertically
echo  2 = flip horizontally
echo  3 = rotate 90 degrees (default)
echo  4 = rotate 180 degrees
echo  5 = rotate 270 degrees
echo  6 = auto rotate
set /p opt=Enter option or press Enter for default (rotate 90 degrees):
if "%opt%"=="" (SET opt=3)
"%app%" /filelist="listfile.txt" /jpg_rotate=^(%opt%,1,0,1^) /killmesoftly
del listfile.txt
color 27 & timeout 2 & exit
:Option_9
echo Setting wallpaper: "%~1"
"%app%" "%~1" /wall=4 /killmesoftly
color 27 & timeout 2 & exit

:shortcut
powershell -NoP -NoL -Ep Bypass -c ^
"$s = (New-Object -ComObject WScript.Shell).CreateShortcut([Environment]::GetFolderPath('SendTo') + '\IrfanView converter.lnk'); ^
$s.TargetPath = '%~f0'; $s.IconLocation = '%app%'; $s.Save()"
echo  Shortcut 'IrfanView converter.lnk' created.
pause & exit

:associate
for /f "tokens=* delims=" %%a in ('where SetUserFTA.exe 2^>nul') do set "fta=%%a"
if not exist "%fta%" (color 4 & echo. & echo  SetUserFTA.exe not found. Try download from: https://setuserfta.com/SetUserFTA.zip & echo. & pause & exit)
(Net session >nul 2>&1)&&(cd /d "%~dp0")||(color 4 & echo. & echo  Pls start as admin & echo. & pause & exit)
echo  Associate image files with "%app%" ? & pause
for %%A in ("%app%") do set "app_dir=%%~dpA"
set "icons=%app_dir%Plugins\Icons.dll"

assoc .jpg=irfan_jpg
ftype irfan_jpg="%app%" "%%1"
SetUserFTA.exe .jpg irfan_jpg
reg add "HKCU\Software\Classes\irfan_jpg\DefaultIcon" /ve /d "%icons%,14" /f

assoc .png=irfan_png
ftype irfan_png="%app%" "%%1"
SetUserFTA.exe .png irfan_png
reg add "HKCU\Software\Classes\irfan_png\DefaultIcon" /ve /d "%icons%,21" /f

assoc .bmp=irfan_bmp
ftype irfan_bmp="%app%" "%%1"
SetUserFTA.exe .bmp irfan_bmp
reg add "HKCU\Software\Classes\irfan_bmp\DefaultIcon" /ve /d "%icons%" /f

assoc .gif=irfan_gif
ftype irfan_gif="%app%" "%%1"
SetUserFTA.exe .gif irfan_gif
reg add "HKCU\Software\Classes\irfan_gif\DefaultIcon" /ve /d "%icons%,10" /f

echo.
SetUserFTA.exe get | findstr /i "irfan"
pause & exit
