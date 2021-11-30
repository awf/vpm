param($area, 
      $resorts = @(), 
      [switch]$fromcsv = $False, 
      [switch]$checkin = $false, 
      [switch]$exact_resort = $false)

if (!$area) {
  throw 'make-vpm AREA [-resorts LIST] [-fromcsv] [-checkin]'
}

$filenamebase = "data/$area" -replace "[* ]","_"
$csvfile = "$filenamebase.csv"

if ($fromcsv) {
  # Don't pull from site, just grab from the old CSV
  $raw= import-csv $csvfile
} else {
  # Grab from seilbahntechnik
  if (!$resorts) {
    $raw = ./grab -exact_resort:$exact_resort $area
  } else {
    $raw = @()
    foreach ($resort in $resorts) {
      $raw += ./grab -exact_resort:$exact_resort $resort
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


$filename = "$filenamebase.html"
write-host "HTML filename [$filename]"

$table = ./raw-to-vpm.ps1 $area $raw -filename $filename

if ($checkin) {
  write-host "*** Checking in ***"

  git add "$filenamebase.*"
  git commit -m "DATA: $area"
  git log -1
}
