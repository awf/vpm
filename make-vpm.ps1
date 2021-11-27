param($area, $resorts = @(), [switch]$checkin = $false, [switch]$fromcsv = $False)

if (!$area) {
  $area = 'Les menuires'
}

$filenamebase = "data/$area" -replace "[* ]","_"
$csvfile = "$filenamebase.csv"

if ($fromcsv) {
  # Don't pull from site, just grab from the old CSV
  $raw= import-csv $csvfile
} else {
  # Grab from seilbahntechnik
  if (!$resorts) {
    $raw = ./grab $area
  } else {
    $raw = @()
    foreach ($resort in $resorts) {
      $raw += ./grab $resort
    }
  }

  if (!$raw.count) {
    write-warning "No lifts found"
    $raw
    return
  }
  write-host "Writing CSV to $csvfile"
  $raw | export-csv $csvfile
}


$filename = "$filenamebase.md"
write-host "Markdown filename [$filename]"

$table = ./raw-to-vpm.ps1 $area $raw -filename $filename

if ($checkin) {
  write-host "*** Checking in ***"

  git add "$filenamebase.*"
  git commit -m "DATA: $area"
  git log -1
}
