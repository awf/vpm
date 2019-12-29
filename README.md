# VPM: Vert Per Minute

What do you want from a ski lift?  I know, I know: no queues, accesses great terrain, a big "Experts only" 
sign to scare away the riffraff.   But you can determine all of that stuff fairly easily by studying the 
map, and I'm assuming that you already ski at off-peak times, in whiteouts, using the singles line, and
generally manage queueing efficiently yourself.

But sometimes you just want to get lots of laps in, 
with the greatest possible height gain in the least time.
You know some of the rules: use the steepest lifts, try the gondolas, 
but is it better to take that 7-minute fast chair or the steep 10-minute T bar?
So I want to maximize VPM (Vert per Minute).

## Running the code.

```
PS> ./make-vpm 'whistler' # Generates data/whistler.md
PS> git commit -m 'DATA: whistler'
PS> git push # update gh pages
```

## Types

| ENG | FRA | DEU | English | Francais | Deutsch |
| -- | -- | -- | -- | -- | -- |
| ATW | TPH | PB | Aerial Tramway | Téléphérique | Pendelbahn |
| MGD | TCD | EUB | Monocable gondola detachable  | Télécabine (débrayable)  | Gondelbahn, Einseilumlaufbahn |
| BGD | 2S | ZUB | Bicable gondola detachable  | Téléphérique débrayable  | Gondelbahn, Zweiseilumlaufbahn |
| TGD | 3S | 3S | Tricable gondola detachable  | Téléphérique  | 3S 3S-Bahn |
| MGFP | TCP | GUB | Monocable gondola fixed grip pulsed  | Télécabine pulsée  | Einseil-Gruppenumlaufbahn |
| MGFJ | NA | GPB | Monocable gondola fixed grip jigback | ? | Einseil-Gruppenpendelbahn |
| BGFP | TPH | ZGPB | Bicable gondola fixed grip pulsed | pulsé | Zweiseil-Gruppenumlaufbahn |
| CLF | TSF | SB | Chairlift fixed grip | Télésiège à pince fixe | Sesselbahn fix geklemmt |
| CLD | TSD | KSB | Chairlift detachable | Télésiège débrayable | kuppelbare Sesselbahn |
| CGD | TMX | KSG | Chairlift gondola detachable | Télé(cabine) mixte | Kombibahn (Sessel + Gondel) |
| FT | FT | FT | Funitel | Funitel | Funitel |
| FUF | FUF | FUF | Funifor | Funifor | Funifor |
| RPC | | | Rope conveyor | | Materialseilbahn |
