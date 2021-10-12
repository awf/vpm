param([string]$uri)

$hd1 = new-object HtmlAgilityPack.HtmlWeb
$l = $hd1.LoadFromWebAsync($uri)
$l.Wait()

if ($l.Status -ne 'RanToCompletion') {
  write-host "http-get-html: Status [$($l.Status)]"
}
$l.Result
