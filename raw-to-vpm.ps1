param($area, $raw, $filename=$null)

function getnumber([string]$data, [string]$unit) {
  #test: (getnumber " 5,47 m/s" "m/s") == 5.47

  $data = $data -replace ',','.' -replace '^ +','' -replace ' +$',''
  if ($data -match '\?\?') { 
    $null
  } elseif ($data -match "([0-9.]+) $unit") {
    [double]($Matches[1])
  }
}

$lifts = $raw | ForEach-Object { 
  $out = 1 | Select-Object valid,name,place,type,url,vert,time,vpm,speed,length,speed_raw,vert_raw,time_raw,length_raw
  $out.name = $_.name
  $out.place = $_.place
  $out.type = $_.type
  $out.url = $_.url
  $out.speed_raw = $_.speed
  $out.vert_raw = $_.vert
  $out.time_raw = $_.time
  $out.speed_raw = $_.speed
  $out.length_raw = $_.length

  $time = getnumber $_.time min
  $speed = getnumber $_.speed "m/s"
  $vert = getnumber $_.vert m

  if (!$vert) {
    $hbot = getnumber $_.hbot m
    $htop = getnumber $_.htop m
    $vert = $htop - $hbot
    write-host "Empty vert, using htop-hbot [$htop-$hbot = $vert]"
  }
  
  $length = getnumber $_.length m
  # write-host "$($_.name) $($_.type) t=$time, l=$length, s=$speed, "

  $time_est = $null
  $add_est = $false
  if ($length -and $speed) {
    $time_est = $length / $speed / 60
    # warn if more than 20sec time diff
    if ($time -and [math]::abs($time - $time_est) -gt 0.3) {
      write-warning ("$($_.name): Estimated time ({0,5:##.#} mins) != recorded ({1,5:##.#} mins)." -f $time,$time_est)
      # So add an estimated one too...
      $add_est = $true
    }
  }

  if (!$time -and $time_est) {
    # write-host "time est: [$length] / [$speed]"
    $time = $time_est
  }

  if ($time -and $vert) {
    $vpm = $vert / $time
    $out.vert = $vert
    $out.vpm = $vpm
    $out.time = $time
    $out.speed = $speed
    $out.length = $length
    $out.valid = 1

    if ($add_est) {
      # Emit an estimated version too
      $out2 = awf-clone $out
      $out2.time = $time_est
      $out2.vpm = ($vert / $time_est)
      $out2.name += " [*]"
      $out2
    }
    write-host -foreground green "Got $($_.name): [$($_.vert)] [$($_.time)] [$($_.speed)] [$($_.length)]"

  } else {
    # We don't have time and vert, can't make vpm
    $out.valid = 0
    write-warning "No time/vert for $($_.name): [$($_.vert)] [$($_.time)] [$($_.speed)] [$($_.length)]"
  }
  $out
}

$lifts = $lifts | Sort-Object -desc vpm

$date = get-date -format y
# create dokuwiki table
$table = $lifts | ForEach-Object {
  "## Lift data for places matching `"$area`""
  "Collected $date"
  Get-Content header.md
} {
  $link = "[link]($($_.url))"
  if ($_.valid) {
    $vert = "{0,5:N0}" -f [math]::round($_.vert)
    $type = $_.type
    $time = "{0,6:N2}" -f $_.time 
    $vpm = "{0,6:N1}" -f $_.vpm
    if ($_.speed_raw -match '\?\? m/s') {
      $speed = " ?"
    } else {
      $speed = "{0,6:N1}" -f [double]$_.speed
    }
    $length = "{0,6:N0}" -f [math]::round($_.length)
    "| $($_.Name) | $type |  $vpm |  $vert |  $time |  $speed |  $length | $link |" 
  } else {
    "| _$($_.Name)_ | $($_.type) |  $($_.vert_raw) | $($_.time_raw) | N/A | $($_.speed_raw) | $($_.length_raw) | $link |" 
  }
}

if ($filename) {
  $table | out-file -enc utf8 "$filename"
} 

$table
