param($area)

if (!$area) {
  $area = '*menuires*'
}

$raw = ./grab $area

if ($raw.count -gt 0) {
  ./raw-to-vpm.ps1 $area $raw
}
