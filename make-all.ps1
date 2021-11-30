param([switch]$fromcsv = $False, [switch]$checkin = $false)

function go {
  ./make-vpm -fromcsv:$fromcsv @args
}

# Make all resorts in the README
go 'Cairngorm'
go 'Champery'
go 'Crystal Mountain'
go 'Espace Killy'
go 'Glenshee'
go 'Tignes'
go 'Val Gardena'
go 'Whistler'
go 'Grimentz'
go 'Paradiski'

go 'Portes du Soleil' -resorts @(
  echo 'Avoriaz' 'Morzine' 'Les Crosets' 'Champoussin' 'Champery'
)
