# Uninstall some built-in UWP apps. Tested on Win 10 22H2 (june 25) and Win 11 24H2

$app2delete = @(
     # Get list of installed apps: Get-AppxPackage | Select Name, PackageFullName
    "Microsoft.Copilot",
    "Microsoft.Windows.DevHome",
    "Microsoft.549981C3F5F10",               # Cortana
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.MicrosoftOfficeHub",          # Office 365
    "microsoft.windowscommunicationsapps",   # Outlook (Mail and Calendar)
    "Microsoft.OutlookForWindows",
    "Microsoft.MicrosoftStickyNotes",
    "Microsoft.Getstarted",                  # Tips
    "Microsoft.MixedReality.Portal",
    "Microsoft.ZuneVideo",                   # Movies & TV
    "Microsoft.BingWeather",
    "Microsoft.Office.OneNote",
    "Microsoft.MSPaint",                     # Paint 3D
    "Microsoft.YourPhone",
    "Microsoft.SkypeApp",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.WindowsMaps",
    "Microsoft.XboxApp",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.GetHelp",
    "Microsoft.People",
     # Win 11:
    "Clipchamp.Clipchamp",
    "Microsoft.BingNews",
    "Microsoft.PowerAutomateDesktop",
    "Microsoft.GamingApp"
)

foreach ($app in $app2delete) {
    try {
        $package = Get-AppxPackage $app -ErrorAction Stop
        if ($package) {
            Remove-AppxPackage $package -ErrorAction Stop
            Write-Output "$app - deleted"
        } else {
            Write-Warning "$app - not found"
        }
    } catch {
        Write-Warning "$app - error deleting"
    }
}

pause