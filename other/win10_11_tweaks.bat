:: Windows quick setup v25.8
:: tested on: Win 11 24H2, Win 10 22H2
:: by t.me/wincmd64

@echo off
(Net session >nul 2>&1)&&(cd /d "%~dp0")||(PowerShell start """%~0""" -verb RunAs & Exit /B)

:: check win ver
for /f %%a in ('powershell.exe -NoP -NoL -NonI -EP Bp -c "(gwmi Win32_OperatingSystem).Caption -Replace '\D'"') do (
   if "%%a"=="10" echo. & echo  RUN SCRIPT for Windows 10 ? & echo. & pause & echo. & goto 10
   if "%%a"=="11" echo. & echo  RUN SCRIPT for Windows 11 ? & echo. & pause & echo. & goto 11
   color 4 & echo The detected system is older than Windows 10. & echo. & pause & goto :eof
) 

:10
echo ==============================================================================
echo    WINDOWS 10
echo ==============================================================================
echo.
echo Создание точки восстановления...
powershell Enable-Computerrestore -drive 'C:\'
VSSAdmin Resize ShadowStorage /For=C: /On=C: /MaxSize=5%%
powershell Checkpoint-Computer -Description 'win10 tweaks script'
@echo on

:: Панель задач. Убирает кнопку новостей
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f

:: Параметры > Система > Многозадачность. OFF "При прикреплении окна показывать, что можно прикрепить рядом с ним" 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SnapAssist /t REG_DWORD /d 0 /f

:: Параметры > Система > Дисплей > Настройки графики. ON "Уменьшить время задержки и увеличить производительность" 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f

:: Проводник. Скрыть папки из 'Этот компьютер' : Объемные объекты, Музыка, Загрузки, Изображения, Видео, Документы, Рабочий стол -- https://www.tenforums.com/tutorials/6015-add-remove-folders-pc-windows-10-a.html
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v ThisPCPolicy /d Hide /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v ThisPCPolicy /d Hide /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v ThisPCPolicy /d Hide /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v ThisPCPolicy /d Hide /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v ThisPCPolicy /d Hide /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v ThisPCPolicy /d Hide /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v ThisPCPolicy /d Hide /f

goto all

:11
echo ==============================================================================
echo    WINDOWS 11
echo ==============================================================================
echo.
echo Создание точки восстановления...
powershell Enable-Computerrestore -drive 'C:\'
VSSAdmin Resize ShadowStorage /For=C: /On=C: /MaxSize=5%%
powershell Checkpoint-Computer -Description 'win11 tweaks script'
@echo on

:: Классическое контекстное меню
:: reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

:: Enable SUDO
sudo config --enable normal

:: Убирает задержку автозапуска СНОВА -- https://superuser.com/questions/1799420/how-to-fix-startupdelayinmsec-trick-does-not-work-anymore
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v WaitforIdleState /t REG_DWORD /d 0 /f

:: Параметры > Система > Многозадачность. OFF "Показывать макеты прикрепления при перетаскивании окна"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableSnapBar /t REG_DWORD /d 0 /f

:: Параметры > Система > Дисплей > Графика. ON "Оптимизация для игр в оконном режиме"
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v DirectXUserGlobalSettings /d "SwapEffectUpgradeEnable=1;" /f

:: Параметры > Система > Спец.возможности > Клавиатура. OFF "Print screen"
reg add "HKCU\Control Panel\Keyboard" /v PrintScreenKeyForSnippingEnabled /t REG_DWORD /d 0 /f

:: Параметры > Персонализация > Пуск > Папки. ON "Загрузки"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Start" /v "VisiblePlaces" /t REG_BINARY /d 2FB367E3DE895543BFCE61F37B18A937 /f

:: Панель задач. Кнопка Пуск слева
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f

::  Параметры > Персонализация > Панель задач. OFF Мини-приложения
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" /v "Value" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f

:: Проводник. Отключает Галерея
reg add "HKCU\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f
:: Проводник. Отключает Главная
:: reg add "HKCU\Software\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f

:: Проводник. Компактное представление
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseCompactMode /t REG_DWORD /d 1 /f

goto all

:all
@echo off
echo.
echo ==============================================================================
echo    UI Tweaks
echo ==============================================================================
@echo on

:: Отключает Lock Screen
:: reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f
:: Отключает фоновое изображение Logon Screen
:: reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v DisableLogonBackgroundImage /t REG_DWORD /d 1 /f

:: Прозрачность окон CMD и PowerShell
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v WindowAlpha /t REG_DWORD /d 231 /f
reg add HKCU\Console\%%SystemRoot%%_System32_WindowsPowerShell_v1.0_powershell.exe /v WindowAlpha /t REG_DWORD /d 243 /f
reg add HKCU\Console\%%SystemRoot%%_SysWOW64_WindowsPowerShell_v1.0_powershell.exe /v WindowAlpha /t REG_DWORD /d 243 /f

:: Определяет положение переключателей в окне Быстродействие (SystemPropertiesPerformance.exe)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9032078010000000 /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /d 0 /f

:: Проводник. Иконка "Этот компьютер" на рабочем столе
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 0 /f

:: Проводник. Скрыть "Дополнительные сведения об этом изображении" на рабочем столе
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {2cc5ca98-6485-489a-920e-b3e88a6ccce3} /t REG_DWORD /d 1 /f

:: Проводник. Запуск по умолчанию "Этот компьютер" вместо "Быстрый доступ"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f

:: Проводник. Отключить "Показывать часто используемые папки на панели быстрого доступа"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f

:: Проводник. Добавляем ярлыки в Быстрый доступ
powershell "(New-Object -ComObject Shell.Application).Namespace('shell:appdata').Self.InvokeVerb('pintohome')"
powershell "(New-Object -ComObject Shell.Application).Namespace('shell:Local AppData\temp').Self.InvokeVerb('pintohome')"
powershell "(New-Object -ComObject Shell.Application).Namespace('shell:startup').Self.InvokeVerb('pintohome')"

:: Проводник. Добавляем "Устройства и принтеры" в "Этот компьютер"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8A91A66-3A7D-4424-8D24-04E180695C7A}" /f

:: Проводник. Всегда показывать расширения файлов
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f

:: Проводник. Отображать защищенные системные файлы (при активации 'Скрытые элементы')
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 1 /f

:: Проводник. Отключить префикс " - ярлык" при создании новых ярлыков
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /v ShortcutNameTemplate /d \"%%s.lnk\" /f

:: Проводник. Отключить сжатие обоев
reg add "HKCU\Control Panel\Desktop" /v JPEGImportQuality /t REG_DWORD /d 100 /f

:: Панель задач. Увеличить скорость открытия миниатюр
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ExtendedUIHoverTime /t REG_DWORD /d 100 /f

:: Панель задач. Переходить на последнее открытое окно при клике по сгруппированным приложениям
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LastActiveClick /t REG_DWORD /d 1 /f

:: Панель задач. Убирает кнопки поиска и задач
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f

:: Пуск. Отключить поиск в Интернете 
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f

:: Пуск. OFF "Отображение уведомлений, связанных с учетной записью"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_AccountNotifications /t REG_DWORD /d 0 /f

:: Пуск. Добавим несколько полезных ярлыков в ОБЩЕМ Пуске
powershell -NoP -NoL -Ep Bp -c "$s=(New-Object -ComObject WScript.Shell).CreateShortcut([IO.Path]::Combine($env:ProgramData, 'Microsoft\Windows\Start Menu\Programs\System Tools\Environment Variables.lnk'));$s.TargetPath = 'rundll32.exe'; $s.Arguments = 'sysdm.cpl,EditEnvironmentVariables';$s.IconLocation='sysdm.cpl,1';$s.Save()"
powershell -NoP -NoL -Ep Bp -c "$s=(New-Object -ComObject WScript.Shell).CreateShortcut([IO.Path]::Combine($env:ProgramData, 'Microsoft\Windows\Start Menu\Programs\System Tools\Device Center.lnk'));$s.TargetPath='explorer';$s.Arguments='shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}';$s.IconLocation='DeviceCenter.dll';$s.Save()"
powershell -NoP -NoL -Ep Bp -c "$s=(New-Object -ComObject WScript.Shell).CreateShortcut([IO.Path]::Combine($env:ProgramData, 'Microsoft\Windows\Start Menu\Programs\System Tools\Network Connections.lnk'));$s.TargetPath='ncpa.cpl';$s.IconLocation='ncpa.cpl';$s.Save()"
powershell -NoP -NoL -Ep Bp -c "$s=(New-Object -ComObject WScript.Shell).CreateShortcut([IO.Path]::Combine($env:ProgramData, 'Microsoft\Windows\Start Menu\Programs\System Tools\Group Policy Editor.lnk'));$s.TargetPath='mmc.exe';$s.Arguments='gpedit.msc';$s.IconLocation='gpedit.dll';$s.Save()"
powershell -NoP -NoL -Ep Bp -c "$s=(New-Object -ComObject WScript.Shell).CreateShortcut([IO.Path]::Combine($env:ProgramData, 'Microsoft\Windows\Start Menu\Programs\System Tools\System Properties.lnk'));$s.TargetPath='control.exe';$s.Arguments='sysdm.cpl';$s.IconLocation='sysdm.cpl';$s.Save()"

:: Панель управления. Крупные значки
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v StartupPage /t REG_DWORD /d 1 /f

:: Панель управления > Звуки. OFF "Проигрывать мелодию запуска Windows"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /v DisableStartupSound /t REG_DWORD /d 1 /f

:: Параметры > Система > Уведомления. OFF "Продолжить способы завершения настройки устройства". Это предотвратит появление навязчивого окна, которое появляется через какое-то время после установки
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f

:: Параметры > Система > Буфер обмена. ON Журнал буфера обмена (Win+V)
reg add "HKCU\Software\Microsoft\Clipboard" /v EnableClipboardHistory /t REG_DWORD /d 1 /f

:: Параметры > Персонализация > Цвета. ON "Заголовки и границы окон"
reg add "HKCU\Software\Microsoft\Windows\DWM" /v ColorPrevalence /t REG_DWORD /d 1 /f

:: Параметры > Персонализация > Панель задач. Несколько дисплеев > Показывать кнопки в которой открыто окно
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V MMTaskbarMode /T REG_dWORD /D 2 /F

:: Параметры > Спец.возможности > Дисплей. OFF "Автоматическое скрытие полос прокрутки"
reg add "HKCU\Control Panel\Accessibility" /v DynamicScrollbars /t REG_DWORD /d 0 /f

@echo off
echo. & echo The settings below have a more advanced format!
echo Please view and edit this file for your needs. & echo.
echo Do you want to continue? & echo.
pause
echo.
echo ==============================================================================
echo     Extended tweaks
echo ==============================================================================
@echo on

:: UserAccountControlSettings.exe - третье положение
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f

:: Часовой пояс UTC+02:00
tzutil /s "FLE Standard Time"

:: Английский как метод ввода по-умолчанию (UA: 0422:00000422 RU: 0419:00000419)
powershell Set-WinDefaultInputMethodOverride -InputTip "0409:00000409"

:: Отключает блокировку скачанных файлов. https://habr.com/ru/post/505194/
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v SaveZoneInformation /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v SaveZoneInformation /t REG_DWORD /d 1 /f

:: Файлы как текстовые
assoc .=txtfile
assoc .wer=txtfile

:: Отключает админ.шары -- https://admx.help/?Category=SecurityBaseline&Policy=Microsoft.Policies.MSS::Pol_MSS_AutoShareWks
reg add HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters /v AutoShareWks /t REG_DWORD /d 0 /f
net share C$ /delete
net share D$ /delete

:: Убирает задержку автозапуска
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f

:: Отключить автозапуск Edge | https://admx.help/?Category=EdgeChromium&Policy=Microsoft.Policies.Edge::StartupBoostEnabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f

:: Телеметрия -- https://admx.help/?Category=Windows_11_2022&Policy=Microsoft.Policies.DataCollection::AllowTelemetry
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f

:: Отключает службу "Функциональные возможности для подключенных пользователей и телеметрия"
sc stop "DiagTrack" && sc config "DiagTrack" start=disabled

:: Отключает задания в планировщике
schtasks /Change /DISABLE /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
:: if still appears: reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /v Debugger /t REG_SZ /d "%windir%\System32\taskkill.exe" /f
schtasks /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag"
schtasks /Change /DISABLE /TN "\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTask"
schtasks /Change /DISABLE /TN "\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTaskLogon"
schtasks /Change /DISABLE /TN "\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTaskNetwork"

:: OFF "Последние действия и результаты сканирования" в Windows Defender (это касается конкретного уведомления - сам AV продолжает работу)
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Virus and threat protection" /v SummaryNotificationDisabled /t REG_DWORD /d 1 /f

:: Электропитание - применять лучше для настольных ПК, а не ноутбуков
:: Отключает гибернацию и удаляет файл C:\hiberfil.sys
powercfg -h off
:: Панель управления > Электропитание. Схема питания "Высокая производительность"
powercfg /S 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
:: Не отключать жесткий диск | https://www.tenforums.com/tutorials/21454-turn-off-hard-disk-after-idle-windows-10-a.html
powercfg -change -disk-timeout-ac 0

pause & exit
