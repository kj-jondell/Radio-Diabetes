(*Dokument uppdaterat:* \today)

# Struktur av system
![Flödesdiagram av system](../media/flowchart.png)

- **Hemsida** (interaktion med användarna -- dvs. uppladdning av mätdata som Excel-fil -- *och* spelar upp musiken; uppbyggd av **Flask** och kopplas på så sätt ihop med Python-server) 
- **Python-server** (tar emot användar-data, tolkar data och servrar) 
- **SuperCollider** (genererar musik) 
* **openFrameworks** (visualisering...)
- **Webbradio** (dvs. *DarkIce* och *IceCast*, som strömmar ut musiken) 

Kommunikation mellan Python-server och SuperCollider-patch (och openFrameworks-program) sker *antingen* i realtid via OSC **eller** asynkront via CSV-filer. 

# Kommunikation ("namespace")
Python-servern kommunicerar med SuperCollider och openFrameworks genom att skicka Osc-meddelanden och Csv-filer. När ny data finns tillgänglig så skickar Python-servern först ett Osc-meddelande på formen:

`[/newPacket, <type>]`

där `type` definierar vilken typ av data som skickas (rådata eller differentierad). Sedan skickar servern ut rådata (värden och tid) på formen:

`[/value, <float>]` och `[/time, <int>]`

där varje mätpunkt (och tidsvärde) skickas med ett Osc-meddelande.

När servern skickat ut alla tillgängliga mätpunkter/tidsvärden kan den även skicka ut information om mätserien, t.ex. olika medelvärden, medianvärden, min- och max-värden etc. Detta skickas i ett meddelande på formen:

`[/meta, [<meta-värden>]]`

där `<meta-värden>` är en array med värden.

Till sist skickar servern ett tomt Osc-meddelande med adressen `/done`.

# Blodsockervärden
Blodsocker mäts i mmol/L och varierar hos en icke-diabetiker mellan 4 och 6 mmol/L. Hos en diabetiker kan detta värde variera från under 1 till över 30 mmol/L, och Freestyle Libre-sensorn har ett spann på att mäta från lägst 2,2 till 27,7 mmol/L (annars visar den "*LO*" (sic) respektive "*HI*" (sic)). Freestyle Libre-sensorn mäter kontinuerligt var 15:e minut.

Att s.k. *mappa* denna data till musikaliska parametrar är förstås godtyckligt -- värdena i sig har ingen musikalisk mening -- och bör så vara: det är helt enkelt min konstnärliga gärning som bestämmer hur de förhåller sig till varandra. Även en bearbetad signal går att använda för att styra musiken: interpolation (mellan de diskreta mätpunkterna), variation (FFT, derivator, etc.), stokastiska egenskaper (auto-korrelation etc), statistiska egenskaper (median, medel, etc.). "*Tid i målområdet*" och liknande värden kan också vara intressanta att använda, och har medicinsk betydelse.

Det som är viktigt i denna *mappning* är dock att den gestaltade datan -- dvs. musiken -- **inte** får avslöja något om den underliggande eller bakomliggande (mät)datan. Dels är det en integritetsfråga, som diskuteras vidare nedan, dels är det en förutsättning för detta projekt: det existerar inga "*bra*" eller "*dåliga*" värden. Delningen av värdena är det viktiga, det är via delningen som det gemensamma sker.

Följande är en plott av interpolerad data från en dag (m.h.a. en BSpline):

![Interpolation](../media/data/interpolated.png)

## Bearbetning

Här är några exempel på bearbetad data:

![Första ordningen differentiering](../media/data/1st-order.png)

![Femte ordningen differentiering](../media/data/5st-order.png)

## Integritet, delning osv.


# Musik (SuperCollider-kod)
Varje instans av mätdata existerar som ett *objekt* i musiken, objekten har vissa attribut (såsom register, spatiell kodning, etc). Koda gärna binauralt (kanske via *Ambisonics*). Klassen har en Osc-tolkarfunktion **eller** CSV-filläsare.

Använd *Diabetessynth* som klangkälla? Kanske även andra Synthar.

Musiken ska vara deterministisk. Parametrarna styrs *helt* av blodsockervärdena.

### Effektkedja
Använda effekter för bl.a. spatialitet (delay/reverb), förstärkning, mixining och manipulation. Waveshaping (saturation/overdrive) och resonatorer...

### Klangkällor / Instrumentation / orkestrering
Följande beskriver vilka ljudkällor (syntesmetoder) som kan tänkas användas:
Fyrstämmig sats; använd **SATB**.

* Elstörnings-*trummaskin* (som jag använde på Landet-konserten...)
	* Genom en (*Moiré*-styrd) resonator... för harmonik/melodik
		* Andra *"instrument"* från min konsert?
* *Diabetessynth* (dvs. granulärsynth/wavetable-synth)
* FM-synth/AM-synth
* Annan granulär/sampler/wavetable-synth
* Diverse fältinspelningar/samplingar
	* Sampla cello?

### Harmonicitet (spektralitet)
Varje *objekt* har följande attribut i förhållande till spektralitet:

* Register
* Tonart (bruksskala)
* Stämning (*renstämd/liksvävig*)
* Klangfärg (bestäms av mätdata?)

### Temporalitet
Varje *objekt* har följande attribut i förhållande till temporalitet:

* Tempo 
* Rytmik

### Spatialitet
Varje *objekt* har följande attribut i förhållande till spatialitet:

* Position
* Bredd


# TODO
1. Kod för musik (skelettkod till en början)
    1. SuperCollider
    1. Python
1. Text till seminarium 
	1. Skelett för layout av examenstext (**deadline 8/11**)
	1. Litteraturstudie
		1. Låna: *Det omätbaras renässans* av Jonna Bornemark

## Diverse
- [ ] Hantera *lo*, *hi*, och mg/dL (ist. för mmol/L).
- [ ] Ska hemsida vara på svenska eller engelska? 
- [x] Merge med "idé"-textfil (se fil i övre mapp...)
- [x] Sätta upp GitHub (pages kanske t.o.m?) 
- [ ] Tänk på vilket register som ska motsvaras av vilken typ av ljudkälla...
- [ ] openFrameworks... visualisering av mätdata?
