param($area)

if (!$area) {
  $area = '*menuires*'
}

$raw = ./grab $area

if (!$raw.count) {
  write-warning "No lifts found"
  $raw
  return
}

$filenamebase = "data/$area" -replace "[* ]","_"

$csvfile = "$filenamebase.csv"
write-host "Writing CSV to $csvfile"
$raw | export-csv $csvfile

$filename = "$filenamebase.md"
write-host "Markdown filename [$filename]"

$table = ./raw-to-vpm.ps1 $area $raw -filename $filename
