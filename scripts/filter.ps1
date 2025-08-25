# Filter for text file with search highlighting and row numbering
# Example usage: .\filter.ps1 -File ".\data.txt" -HeaderLines 2

param(
    [string]$File   = "$PSScriptRoot\$(($MyInvocation.MyCommand.Name -split '\.')[0]).txt",
    [int]   $HeaderLines = 1
)

if (-not (Test-Path $File)) { Write-Warning "File not found: $File"; exit }
$Host.UI.RawUI.WindowTitle = "Filter: $File"

# read ignoring empty lines
$data = Get-Content $File | Where-Object { $_ -ne '' }
if ($data.Count -le $HeaderLines) { Write-Warning "Not enough lines for the specified header size"; exit }

$rowsTotal   = $data.Count - $HeaderLines
$numberWidth = ($rowsTotal).ToString().Length
$prefix      = ' ' * ($numberWidth + 1)

while ($true) {
    Clear-Host
    for ($i = 0; $i -lt $HeaderLines; $i++) {
        Write-Host -NoNewline $prefix
        Write-Host $data[$i]
    }

    $filter = Read-Host "> "
    $count = 0

    foreach ($line in $data[$HeaderLines..($data.Count-1)]) {
        if (-not $filter -or $line -match [regex]::Escape($filter)) {
            $count++
            Write-Host -NoNewline ("{0:D$numberWidth} " -f $count)

            if ($filter) {
                $pattern = [regex]::Escape($filter)
                $pos = 0
                while ($pos -lt $line.Length) {
                    $m = [regex]::Match($line.Substring($pos), $pattern)
                    if ($m.Success) {
                        Write-Host -NoNewline $line.Substring($pos, $m.Index) -ForegroundColor White
                        Write-Host -NoNewline $m.Value -ForegroundColor Yellow
                        $pos += $m.Index + $m.Length
                    } else {
                        Write-Host -NoNewline $line.Substring($pos) -ForegroundColor White
                        break
                    }
                }
                Write-Host ""
            } else {
                Write-Host $line
            }
        }
    }

    Write-Host "`nTotal: $count / $rowsTotal"
    Pause
}
