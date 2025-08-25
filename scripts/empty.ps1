<#
.SYNOPSIS
Recursively deletes empty files and folders.

.DESCRIPTION
-dir     Directory to scan. Defaults to current directory.
-test    Test mode. No deletions made, only counts displayed.

.PARAMETER dir
Directory to scan. Defaults to current directory.

.PARAMETER test
Test mode. No deletions made, only counts displayed.

.EXAMPLE
powershell -Ep Bypass empty.ps1 -dir $env:TEMP

.LINK
https://github.com/wincmd64
#>

param (
    [string]$dir = (Get-Location).Path,
    [switch]$test
)

if (-not (Test-Path -Path $dir)) { Write-Warning "The directory '$dir' does not exist." ; exit 1 }
Write-Host "`n Scanning path: $dir"

$logFile = "$env:TEMP\$(($MyInvocation.MyCommand.Name -split '\.')[0])_errors.log"
$deletedFiles = $deletedFolders = $errors = 0

function Try-Remove {
    param ($item)
    try {
        Remove-Item -LiteralPath $item.FullName -Force -ErrorAction Stop
        return $true
    } catch {
        Add-Content -Path $logFile -Value "$(Get-Date -f 'yy-MM-dd-HH-mm-ss'): $_"
        $script:errors++
        return $false
    }
}

# Delete empty files
Get-ChildItem -Path $dir -File -Recurse -Force -ErrorAction SilentlyContinue |
    Where-Object { $_.Length -eq 0 } |
    ForEach-Object {
        if ($test) { $deletedFiles++ } elseif (Try-Remove $_) { $deletedFiles++ }
    }

# Delete empty folders (starting with the deepest ones)
Get-ChildItem -Path $dir -Directory -Recurse -Force -ErrorAction SilentlyContinue |
    Sort-Object FullName -Descending |
    ForEach-Object {
        if (-not (Get-ChildItem -Path $_.FullName -Force -ErrorAction SilentlyContinue)) {
            if ($test) { $deletedFolders++ } elseif (Try-Remove $_) { $deletedFolders++ }
        }
    }

# Final summary
if ($test) {
    Write-Host " TEST MODE. Will try to delete $deletedFiles empty files and $deletedFolders empty folders.`n" -ForegroundColor Cyan
} else {
    Write-Host " Deleted empty files:   $deletedFiles`n Deleted empty folders: $deletedFolders`n"
    if ($errors -gt 0) {
        Write-Host " Errors: $errors" -ForegroundColor Red
        Write-Host " Log file created: $logFile`n" -ForegroundColor Cyan
    }
}
