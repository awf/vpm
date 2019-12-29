param([string]$uri)

$hd1 = new-object HtmlAgilityPack.HtmlWeb
$l = $hd1.LoadFromWebAsync($uri)
$l.Wait()

write-host "Status [$($l.Status)]"
$l.Result
