# Recursively deletes files older than X days in specified folder
#
# Example usage: powershell -Ep Bypass clean.ps1 -d 7 -dir "C:\temp" -ext ".tmp .log"
#
# Parameters (optional):
# -d X                    : Specifies that files older than X days will be deleted; default is 30
# -dir "path"             : Specifies the directory to search for files; default is %temp%
# -ext ".ext1 .ext2 ..."  : Specifies the file extensions to delete
# -test                   : Runs in test mode. No deletions are made - only a count is displayed

param (
    [int]$d = 30,
    [string]$dir = $env:TEMP,
    [string]$ext,
    [switch]$test
)

# Check params
if ($d -le 0) { Write-Warning "Please use -d to specify a positive number of days." ; exit 1 }
if (-not (Test-Path -Path $dir)) { Write-Warning "The directory '$dir' does not exist." ; exit 1 }

Write-Host `n"Scanning path: $dir"

$logFile="$env:TEMP\$(($MyInvocation.MyCommand.Name -split '\.')[0])_$(Get-Date -f 'yy-MM-dd-HH-mm-ss').log"
$count = $errorCount = 0

# Create an array of extensions if provided
$extensions = if ($ext) { $ext -split ' ' } else { @() }

# Get files to delete based on the specified extensions
$filesToDelete = Get-ChildItem -EA SilentlyContinue -Path $dir -File -Recurse | 
    Where-Object {
        $_.LastWriteTime -lt (Get-Date).AddDays(-$d) -and 
        ($extensions.Count -eq 0 -or $extensions -contains $_.Extension)
    }

if ($filesToDelete.Count -eq 0) {
    Write-Host "No files found to delete."`n
} else {
    if ($test) {
        $extensionCounts = @{}
        $extensionFiles  = @{}
    
        foreach ($file in $filesToDelete) {
            $extName = if ([string]::IsNullOrWhiteSpace($file.Extension)) { '.' } else { $file.Extension }
    
            if ($extensionCounts.ContainsKey($extName)) {
                $extensionCounts[$extName]++
            } else {
                $extensionCounts[$extName] = 1
                $extensionFiles[$extName]  = $file.Name
            }
        }
    
        Write-Host "TEST MODE. Will try to delete $($filesToDelete.Count) files older $d days:" -ForegroundColor Cyan
    
        # > 1
        $multiGroup = $extensionCounts.Keys | Where-Object { $extensionCounts[$_] -gt 1 }
        if ($multiGroup.Count -gt 0) {
            $line = ($multiGroup | Sort-Object { -$extensionCounts[$_] } | ForEach-Object { "$_ - $($extensionCounts[$_])" }) -join ' '
            Write-Host $line
        }
    
        # single .ext
        $singleGroup = $extensionCounts.Keys | Where-Object { $extensionCounts[$_] -eq 1 }
        foreach ($ext in $singleGroup) {
            Write-Host "$($extensionFiles[$ext])"
        }
    
        Write-Host
    } else {
        # Initialize progress bar
        $progressParams = @{
            Activity = "Deleting files"
            CurrentOperation = "Finding files to delete..."
            PercentComplete = 0
        }
        Write-Progress @progressParams
        
        $totalFiles = $filesToDelete.Count
        foreach ($file in $filesToDelete) {
            try {
                Remove-Item -Path $file.FullName -Force -ErrorAction Stop
                $count++
                # Update progress bar
                $progressParams.PercentComplete = [math]::Round(($count / $totalFiles) * 100)
                $progressParams.CurrentOperation = "Deleting: $($file.FullName)"
                Write-Progress @progressParams
            } catch {
                Add-Content -Path $logFile -Value "Error deleting $($file.FullName): $_"
                $errorCount++
            }
        }
        
        # Complete progress bar
        $progressParams.PercentComplete = 100
        $progressParams.CurrentOperation = "Completed"
        Write-Progress @progressParams
        
        # Summary
        Write-Host "Deleted files: $count"
        if ($errorCount -gt 0) {
            Write-Host "Files with errors: $errorCount" -ForegroundColor Red
            Write-Host "Log file created: $logFile" -ForegroundColor Cyan
        }
        Write-Host
    }
}
