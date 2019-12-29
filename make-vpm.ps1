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

$filename = "data/$area.md" -replace "[* ]","_"
write-host "dokuwiki filename [$filename]"

$table = ./raw-to-vpm.ps1 $area $raw -filename $filename

