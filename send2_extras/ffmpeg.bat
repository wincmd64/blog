:: Various ffmpeg commands
:: by github.com/wincmd64

:: Usage:
:: Create a shortcut to this .bat file in the Shell:SendTo folder
:: or button in TotalCmd with the %P%S parameter

:: Command line arguments:
:: /s - create shortcut in Shell:SendTo folder

:: Note: this file must use code page OEM 866

@echo off
setlocal
:: get ffmpeg path
for /f "tokens=* delims=" %%a in ('where ffmpeg.exe 2^>nul') do set "app=%%a"
if not exist "%app%" (color 4 & echo. & echo  ffmpeg.exe not found. Try: winget install Gyan.FFmpeg & echo. & pause & exit) else (TITLE %app%)

:: arguments
if "%~1"=="/s" (if "%~2"=="" goto :shortcut)

echo.
echo  ÛÛÛÛÛÛÛ»ÛÛÛÛÛÛÛ»ÛÛÛ»   ÛÛÛ»ÛÛÛÛÛÛ» ÛÛÛÛÛÛÛ» ÛÛÛÛÛÛ» 
echo  ÛÛÉÍÍÍÍ¼ÛÛÉÍÍÍÍ¼ÛÛÛÛ» ÛÛÛÛºÛÛÉÍÍÛÛ»ÛÛÉÍÍÍÍ¼ÛÛÉÍÍÍÍ¼ 
echo  ÛÛÛÛÛ»  ÛÛÛÛÛ»  ÛÛÉÛÛÛÛÉÛÛºÛÛÛÛÛÛÉ¼ÛÛÛÛÛ»  ÛÛº  ÛÛÛ»
echo  ÛÛÉÍÍ¼  ÛÛÉÍÍ¼  ÛÛºÈÛÛÉ¼ÛÛºÛÛÉÍÍÍ¼ ÛÛÉÍÍ¼  ÛÛº   ÛÛº
echo  ÛÛº     ÛÛº     ÛÛº ÈÍ¼ ÛÛºÛÛº     ÛÛÛÛÛÛÛ»ÈÛÛÛÛÛÛÉ¼
echo  ÈÍ¼     ÈÍ¼     ÈÍ¼     ÈÍ¼ÈÍ¼     ÈÍÍÍÍÍÍ¼ ÈÍÍÍÍÍ¼ 
echo.
:: checking the number of selected files
set count=0
for %%A in (%*) do set /a count+=1

if %count% equ 0 (echo  No files selected & echo. & pause & exit)

if %count% equ 1 (
    echo  Processing: %* & echo.
    if "%~x1"=="" echo  NOTICE: first argument is likely a folder or has no extension. & echo.
    echo  1 = Remove audio
    echo  2 = Extract audio
    echo  3 = Create GIF
    echo  4 = Cut video
    echo  5 = 2x fast
    echo  6 = 0.5x speed
    echo  7 = Convert to 1080p ^(x264^)
    echo  8 = Rotate right
    echo  9 = Rotate left
    echo.
    CHOICE /C 123456789 /M "Your choice?:" >nul 2>&1
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
) else (
    goto :MultiFile
)
goto :eof
:Option_1
"%app%" -i %1 -an -vcodec copy "%~dpn1_noaudio%~x1"
color 27 & timeout 2 & exit
:Option_2
"%app%" -i %1 -map 0:a:0 -c:a copy -vn "%~dpn1_audio%~x1"
color 27 & timeout 2 & exit
:Option_3
"%app%" -i %1 -vf "fps=15,scale=320:-1:flags=lanczos" "%~dpn1.gif"
color 27 & timeout 2 & exit
:Option_4
echo.
"%app%" -i %1 2>&1 | find "Duration"
echo.
set /p start=Start time (e.g. 00:00:03): 
if "%start%"=="" set start=00:00:00
set /p end=End time (e.g. 00:00:30): 
"%app%" -i %1 -ss %start% -to %end% -c:v libx264 -c:a copy "%~dpn1_cut%~x1"
color 27 & timeout 2 & exit
:Option_5
"%app%" -i %1 -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]" -map "[v]" -map "[a]" "%~dpn1_fast%~x1"
color 27 & timeout 2 & exit
:Option_6
"%app%" -i %1 -filter_complex "[0:v]setpts=2.0*PTS[v];[0:a]atempo=0.5[a]" -map "[v]" -map "[a]" "%~dpn1_slow%~x1"
color 27 & timeout 2 & exit
:Option_7
"%app%" -i %1 -c:v libx264 -crf 23 -preset fast -c:a copy "%~dpn1_1080p%~x1"
color 27 & timeout 2 & exit
:Option_8
"%app%" -i %1 -vf "transpose=1" -c:v libx264 -crf 18 -preset veryfast -c:a copy "%~dpn1_R%~x1"
color 27 & timeout 2 & exit
:Option_9
"%app%" -i %1 -vf "transpose=2" -c:v libx264 -crf 18 -preset veryfast -c:a copy "%~dpn1_L%~x1"
color 27 & timeout 2 & exit

:MultiFile
if "%~x1"=="" echo  NOTICE: first argument is likely a folder or has no extension. & echo.
echo  Merge %count% files? & echo. & pause
chcp 65001 >nul
pushd "%~dp1"
(
    for %%i in (%*) do @echo file '%%~fi'
) > "listfile.txt"
"%app%" -f concat -safe 0 -i listfile.txt -c copy "MergeOutput.mp4"
del listfile.txt
color 27 & timeout 2 & exit

:shortcut
powershell -NoP -NoL -Ep Bypass -c ^
"$s = (New-Object -ComObject WScript.Shell).CreateShortcut([Environment]::GetFolderPath('SendTo') + '\FFmpeg Tools.lnk'); ^
$s.TargetPath = '%~f0'; $s.IconLocation = 'shell32.dll,115'; $s.Save()"
echo  Shortcut 'FFmpeg Tools.lnk' created.
pause & exit
