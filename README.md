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

Up to date file is now make-vpm.ps1

Then cp2awfie-liftdata


## types:

# ATW Aerial Tramway 
# MGD Monocable gondola detachable 
# BGD Bicable gondola detachable 
# TGD Tricable gondola detachable 
# MGFP Monocable gondola fixed grip pulsed 
# MGFJ Monocable gondola fixed grip jigback 
# BGFP gondola fixed grip pulsed
# CLF  Chairlift fixed grip 
# CLD  Chairlift detachable 
# CGD  Chairlift gondola detachable 
# FT   Funitel  
# FUF  Funifor  
# RPC  Rope conveyor  
# SL   Surface lift


^ EN ^ FR ^ DE ^ English ^ Fran�ais ^ Deutsch ^
| ATW | TPH | PB | Aerial Tramway | T�l�ph�rique | Pendelbahn |
| MGD | TCD | EUB | Monocable gondola detachable  | T�l�cabine (d�brayable)  | Gondelbahn, Einseilumlaufbahn |
| BGD | 2S | ZUB | Bicable gondola detachable  | T�l�ph�rique d�brayable  | Gondelbahn, Zweiseilumlaufbahn |
| TGD | 3S | 3S | Tricable gondola detachable  | T�l�ph�rique  | 3S 3S-Bahn |
| MGFP | TCP | GUB | Monocable gondola fixed grip pulsed  | T�l�cabine puls�e  | Einseil-Gruppenumlaufbahn |
| MGFJ | NA | GPB | Monocable gondola fixed grip jigback | ? | Einseil-Gruppenpendelbahn |
| BGFP | TPH | ZGPB | Bicable gondola fixed grip pulsed | puls� | Zweiseil-Gruppenumlaufbahn |
| CLF | TSF | SB | Chairlift fixed grip | T�l�si�ge � pince fixe | Sesselbahn fix geklemmt |
| CLD | TSD | KSB | Chairlift detachable | T�l�si�ge d�brayable | kuppelbare Sesselbahn |
| CGD | TMX | KSG | Chairlift gondola detachable | T�l�(cabine) mixte | Kombibahn (Sessel + Gondel) |
| FT | FT | FT | Funitel | Funitel | Funitel |
| FUF | FUF | FUF | Funifor | Funifor | Funifor |
| RPC | | | Rope conveyor | | Materialseilbahn |
