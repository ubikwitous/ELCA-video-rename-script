# Path to folder and liturgical calendar CSV (update path to CSV if needed)
$folder = "D:\Recordings"
$csvPath = "D:\Scripts\elca_liturgical_calendar_2022_2050.csv"

# Load calendar with normalized DateTime keys
$calendar = @{}
Import-Csv -Path $csvPath | ForEach-Object {
    $parsedDate = [datetime]::Parse($_.RecordingDate.Trim())
    if (-not [string]::IsNullOrWhiteSpace($_.PrimaryLiturgicalTitle)) {
        $calendar[$parsedDate.Date] = $_.PrimaryLiturgicalTitle.Trim()
    }
}

# Track how many files per date to apply suffixes
$fileCount = @{}

# Process each .mp4 file
Get-ChildItem -Path $folder -Filter *.mp4 | ForEach-Object {
    $modDate = $_.LastWriteTime.Date

    if ($calendar.ContainsKey($modDate)) {
        $title = $calendar[$modDate] -replace '[\\/:*?"<>|]', ''
        if (-not $fileCount.ContainsKey($modDate)) {
            $fileCount[$modDate] = 0
        }

        $suffix = ""
        if ($fileCount[$modDate] -eq 1) {
            $suffix = "-A"
        } elseif ($fileCount[$modDate] -gt 1) {
            $suffix = "-" + [char](64 + $fileCount[$modDate])
        }

        $fileCount[$modDate]++
        $formattedDate = $modDate.ToString("yyyy-MM-dd")
        $newName = "$formattedDate $title$suffix.mp4"
        $newPath = Join-Path -Path $folder -ChildPath $newName
        Rename-Item -Path $_.FullName -NewName $newPath
        Write-Host "Renamed '$($_.Name)' to '$newName'"
    } else {
        Write-Warning "No liturgical title found for $($modDate.ToShortDateString()). Skipping '$($_.Name)'"
    }
}