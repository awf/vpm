$pkg = Get-Package HtmlAgilityPack

if (!$pkg) {
    $pkg = Install-Package -verbose -scope CurrentUser HtmlAgilityPack
}

$pkgdir = (get-item $pkg.source).Directory
$dllpath = Get-ChildItem $pkgdir -rec *.dll | `
    Where-Object { $_.Directory.Basename -eq 'netstandard2.0' }

add-type -path $dllpath
