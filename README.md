What do you want from a ski lift?  I know, I know: no queues, accesses great terrain, a big "Experts only" 
sign to scare away the riffraff.   But you can determine all of that stuff fairly easily by studying the 
map, and I'm assuming that you already ski at off-peak times, in whiteouts, using the singles line, and
generally manage queueing efficiently yourself.

But sometimes you just want to get lots of laps in, 
with the greatest possible height gain in the least time.
You know some of the rules: use the steepest lifts, try the gondolas, 
but is it better to take that 7-minute fast chair or the steep 10-minute T bar?

What I really want to know is VPM (Vert per Minute): the vertical rise of the lift divided by ride time.  A really fast lift, like Whistler's [Peak Express chair](https://www.youtube.com/watch?v=K9Ia3C_XgBk) climbs at about 100 metres per minute, which is a good target to aim for.

Note that we are definitely in pinch of salt territory here. The line length and vertical gain figures are pretty solid, but the ride time is generally not very accurate. Lift operators run the lift slower or faster depending on conditions, possibly varying the ride time by a factor of two or more from these estimates. The entries marked [*] have had ride time computed from the line speed, which is again pretty nominal, and for some lifts you can see entries for both the estimated and supplied ride times, which typically differ by about 15%.

Lift type also plays a rôle. Most of the high-VPM lifts are cable cars or trains, which don't run continuously, so when you factor in a wait time that's typically the same as the ride time, they can be less attractive (although still pretty good, especially if you know one is coming soon). Similarly, the next class is high-speed gondolas, where wait time (ignoring queueing) is much smaller, but you still need to take your skis off and trudge through some infrastructure. Perhaps add a minute to the ride time for these, discounting vpm by 10-30%. For me, the kings of the mountain are the high-speed detachable chairs (CLDs below). There's no faff time, and you're skiing the moment you get to the top.

The data needed to compute VPM comes from the most excellent [seilbahntechnik.net](http://seilbahntechnik.net)

## Resorts

Runs are manual, to avoid spamming [seilbahntechnik.net](http://seilbahntechnik.net), so post a [github issue](https://github.com/awf/vpm/issues/new?assignees=awf&labels=&template=resort-request.md&title=Add+resort%3A+RESORT+NAME) if you want to propose a new resort.

* North America
  - [Whistler](data/Whistler)
  - [Crystal Mountain](data/Crystal_Mountain)
  - [Crested Butte](data/Crested_Butte) ([Cross reference](https://travelcrestedbutte.com/hurry-fastest-crested-butte-ski-lifts/))
* France
  - [Espace Killy](data/Espace_Killy)
    - Just [Tignes](data/Tignes)
  - [Portes du Soleil](data/Portes_du_Soleil)
* Italy
  - [Val Gardena](data/Val_Gardena)
* Switzerland
  - [Grimentz - Zinal](data/Grimentz)
* Scotland
  - [Cairngorm](data/Cairngorm)
  - [Glenshee](data/Glenshee)

## Running the code.

```
PS> . ./setup # installs HtmlAglityPack
PS> ./make-vpm 'Whistler' # Generates data/Whistler.{md,csv}

PS> ./make-vpm 'Whistler' -checkin # Checks in the new data

PS> git push # update gh pages
```
For areas that don't grep well (e.g. the "Area" field is inconsistently filled in), then you can supply a list of resorts using the `-resorts` option.

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
