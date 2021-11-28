$places = Get-ChildItem .\data\*.html | ForEach-Object { 
        $file = $_
        Get-Content $file | ForEach-Object { 
            if ($_ -match 'Lift data for places matching "(.*)"') { 
                $out = 1 | Select-Object file,name
                $out.file = $file
                $out.name = $Matches[1] 
                $out
            } 
        } 
    }

write-host $places

foreach ($place in $places) {
    $name = $place.name
    $file = $place.file
    $csv = $file -replace '\.html$','.csv'
    $raw = Import-Csv $csv    
    $table = .\raw-to-vpm.ps1 $name $raw -filename $file
}
