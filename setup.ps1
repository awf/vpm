$pkg = Get-Package HtmlAgilityPack

if (!$pkg) {
    $pkg = Install-Package -verbose -scope CurrentUser HtmlAgilityPack
    # Errors here?
    # Consider:
    # Register-PackageSource -Name MyNuGet -Location https://www.nuget.org/api/v2 -ProviderName NuGet 
    # Install-Package -scope CurrentUser HtmlAgilityPack -SkipDependencies
}

$pkgdir = (get-item $pkg.source).Directory
$dllpath = Get-ChildItem $pkgdir -rec *.dll | `
    Where-Object { $_.Directory.Basename -eq 'netstandard2.0' }

add-type -path $dllpath
