
# Make all resorts in the README
.\make-vpm 'Cairngorm'
.\make-vpm 'Champery'
.\make-vpm 'Crystal Mountain'
.\make-vpm 'Espace Killy'
.\make-vpm 'Glenshee'
.\make-vpm 'Tignes'
.\make-vpm 'Val Gardena'
.\make-vpm 'Whistler'
.\make-vpm 'Grimentz'

.\make-vpm.ps1 'Portes du Soleil' -resorts @(
  echo Avoriaz Morzine 'Les Crosets' Champoussin Champery
)
