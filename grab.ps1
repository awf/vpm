param($area)

if (!$area) {
  $area = '*menuires*'
}
write-host "Loading data for [$area]"

$ignore = '*'
$fields = @{
  "Height of valley station" = 'hbot';
  "Height of middle station(s)" = 'hmid';
  "Height of mountain station" = 'htop';
  "Vertical rise" = 'vert';
  "Route distance" = 'length';
  "Horizontal length" = 'horz';
  "Average incline" = 'incline';
  "Largest incline" = 'incmax';
  "Number of pillars" = 'pillars';
  "Year of closing down" = 'closed';
  "Track width" = 'trkwidth';
  "Driving station" = $ignore;
  "Tension station" = $ignore;
  "Tension type" = $ignore;
  "Tension way" = $ignore;
  "Rope manufacturer" = $ignore;
  "Length of rope" = $ignore;
  "Total weight of rope" = $ignore;
  "Rope diameter" = $ignore;
  "Electrical engineering" = $ignore;
  "Drive power (Start)" = $ignore;
  "Drive power (Operation)" = $ignore;
  "Brake power" = $ignore;
  "Grip type" = $ignore;
  "Cab manufacturer" = $ignore;
  "Cab model" = $ignore;
  "Seat cover" = 'covered';
  "Seat heater" = 'heated';
  "Number of cabs" = 'cabins';
  "Persons per cab" = $ignore;
  "Cab distance..." = $ignore;
  "Cab interval..." = $ignore;
  "Maximum capacity" = $ignore;
  "Travel time" = 'time';
  "Driving speed line" = 'speed';
  "Transport uphill" = $ignore;
  "Transport downhill" = $ignore;
  "Drive direction" = $ignore;
  "Garage type" = $ignore;
  "Garage place" = $ignore;
  "Situation of entrance" = $ignore;
  "Situation of exit" = $ignore;
  "Construction period" = $ignore;
}

# https://lift-world.info/en/lifts/searchresult.htm?sprache=en&suchoption=erweitert&eOrt=whistler

$base = 'https://lift-world.info'

# Get the summary page

# Search by resort ("eSkigebiet") or place ("eOrt")
$h = ''
$url = "$base/en/lifts/searchresult.htm?sprache=en&suchoption=volltext&eingabe=$area"
$url+= "&liftstatus1=1&liftstatus2=1&liftstatus3=1" # Remove replaced/decomissioned lifts
write-host "$url"
$h = ./http-get-html $url

$failed = ($h.DocumentNode.OuterHtml -split "`n" | Select-String "Your search did not")
if ($failed) {
  write-warning "http://www.seilbahntechnik.net says $failed, trying next"
} 

$n = $h.DocumentNode.CreateNavigator()

# find all "details" links
$lifts = $n.Select('//i[contains(@title,"Show technical")]/parent::a') | `
  ForEach-Object { $_.GetAttribute('href','') }

if (!$lifts) {
  throw "no lifts"
}

write-host "Got $($lifts.count) lifts"

function strip([string]$s) {
  $s -replace "[`n`r`t]",' ' -replace '&nbsp;',' ' -replace "[`n`r`t ]+$",'' -replace "^[`n`r`t ]+",''
}

$fieldnames = @("name","place","type","url") + ($fields.Values | Where-Object { $_ -ne '' } | Sort-Object -Unique)

$lifts | ForEach-Object {
  $url = $_

  # make an empty "out" object
  $out = 1 | Select-Object $fieldnames

  $out.url = "$base$url"
  $h1 = (./http-get-html $out.url).DocumentNode

  # Extract info from "General information" pane
  $gitbl = '//th[contains(., "General information")]/ancestor::table[1]'
  $out.place = strip ($h1.SelectSingleNode($gitbl+'/descendant::td[contains(.,"Place")]/following-sibling::td').innertext)
  $out.name = strip ($h1.SelectSingleNode($gitbl+'/descendant::td[contains(.,"Name of lift")]/following-sibling::td').innertext)
  $out.type = strip ($h1.SelectSingleNode($gitbl+'/descendant::td[contains(.,"Type")]/following-sibling::td').innertext)

  # Extract info from "geometric data" pane
  # Collect fields -- one label_td for each 
  $label_tds = $h1.SelectNodes('//th[contains(., "geometric data")]/parent::tr/following-sibling::tr/td[1]')

  # Collect fields -- label_td's following siblings have value
  $label_tds | ForEach-Object {
    $fieldtext = strip $_.InnerText
    $value = strip $_.NextSibling.NextSibling.InnerText
    $field = $fields[$fieldtext]
    if ($field) {
      if ($field -ne $ignore) {
        # write-host "[$field] = [$value]"
        $out.$field = $value
      } else {
        if ($value -notmatch '^\?\?') {
          write-host "Ignored field [$fieldtext] with nonempty value = [$value]"
        }
      }
    } else {
      if ($value -notmatch '^\?\?') {
        write-host "Unknown field [$fieldtext] with nonempty value = [$value]"
      }
    }

    if ($out.closed) {
      write-host "$($out.name) closed in $($out.closed)";
      continue
    }
  }
  
  write-host "$($out.name) $($out.type) $($out.time) $($out.vert) $($out.speed)"
  # And emit to the stream
  $out
}
