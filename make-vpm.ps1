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

$table = ./raw-to-vpm.ps1 $area $raw 

$filename = "data/$area.txt" -replace " ","_"
write-host "dokuwiki filename [$filename]"
$table | out-file -enc utf8 "$filename"
