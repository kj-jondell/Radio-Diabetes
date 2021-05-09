import "./about.css";
import React from "react";
import Thesis from "../documents/kandidat.pdf";
import { Link } from "react-router-dom";

export function About() {
  return (
    <div className="infotext">
      <h2>Om</h2>
      <div className="breadText">
        <h3 style={{ marginTop: "0" }}>Vad är detta?</h3>
        <p>
          <em>Radio Diabetes</em> är en interaktiv ljud&shy;installation som
          skapar musik av blod&shy;sockervärden. Installationen har jag,{" "}
          {/*&mdash;*/}
          Karl Johannes Jondell, byggt som examens&shy;projekt för min
          kandidat&shy;utbildning inom elektro&shy;akustisk komposition på
          Kungliga Musik&shy;högskolan.
        </p>
        <p>
          {" "}
          Idéen föddes av att jag som diabetiker känt ett behov av att
          av&shy;dramatisera mitt förhållande till mina blod&shy;sockerkurvor:
          att göra något kul och spännande av dem, att de inte <em>bara</em> är
          ett mått på hur väl jag "presterar" som diabetiker, utan att de också
          kan ge upphov till något fint och lustfyllt.
        </p>
        <p>
          Jag vill erbjuda <b>alla</b> diabetiker denna chans, och även chansen
          att dela med sig av sina värden utan att de bedöms, utan att det är en
          prestation, utan något stigma, ett prestigelöst delande. Min
          förhoppning är att denna installation på ett lekfullt sätt kan ge
          upphov till en ytterligare gemenskap för oss diabetiker, som inte
          behöver vara lika allvarlig och allvarsam som själva sjukdomen.
        </p>
        <h3>Hur fungerar det?</h3>
        <p>
          Musiken som spelas upp i radion genereras i realtid av ett program som
          jag byggt: musiken du hör skapas alltså i samma stund som den spelas
          upp. Programmet i sin tur skapar de olika melodier och tonföljder som
          hörs utifrån de blodsockervärden som delas på{" "}
          <Link to="/uppladdning">Uppladdnings</Link>-sidan. När någon laddar
          upp sina värden så skickas de direkt vidare till
          musik&shy;skapar&shy;programmet, som spelar upp ett tack-meddelande
          och sedan låter värdena styra någon musikalisk funktion i programmet.
          Till exempel kan värdena få styra tonhöjd av en nyskapad synth.
        </p>
        <p>
          {" "}
          Om du hör en röst säga "tack så mycket" innebär det alltså att någon i
          denna stund delat med sig av sina värden. Efter detta kanske du lägger
          märke till att en ny ljudande figur ger sig till känna: denna skapas
          alltså utifrån de värden som precis laddats upp!
        </p>
        <p>
          {" "}
          Om det är många som delar med sig av sina värden samtidigt, kan några
          läggas på kö, för att spelas upp senare. Så om du laddar upp värden,
          och hör ett tack-meddelande, men inte hör någon särskild förändring i
          musiken, är det möjligt att dina värden har lagts på kö. Håll till
          godo, de kommer att spelas upp inom kort!
        </p>
        <p>
          En mer teknisk be&shy;skrivning av hela systemet finns att läsa i min
          examens&shy;text <a href={Thesis}>här</a>.
        </p>
        <div id="gdpr">
          <h3>Dataanvändning och GDPR</h3>
          <p>
            Jag vill vara tydlig med att <b>ingen</b> datafil sparas på servern.
            Varken jag eller någon annan har möjlighet att komma åt filerna som
            laddas upp. När en fil laddas upp så anonym&shy;iseras innehållet
            direkt, och endast värdena slussas vidare till musik&shy;programmet,
            som endast temporärt sparar dessa i sitt arbets&shy;minne. Ingen har
            alltså tillgång till de värden som laddas upp, och de kan inte
            kopplas till någon individ. Ovan beskrivs hur behandlingen av
            värdena sker, och en mer teknisk redogörelse finns att läsa i min
            examens&shy;text <a href={Thesis}>här</a>.
          </p>
          <p>
            Enligt data&shy;skyddsförordningen (
            <a href="https://www.imy.se/lagar--regler/dataskyddsforordningen/kansliga-personuppgifter/">
              GDPR
            </a>
            ) klassas blod&shy;sockervärden som{" "}
            <em>särskilt känsliga uppgifter</em>. Därför måste du som laddar upp
            ge ditt samtycke till att värdena som du laddar upp används och
            behandlas för detta ändamål. Känner du dig minsta osäker så
            välkomnar jag alla frågor på{" "}
            <a href="mailto:info@radiodiabetes.eu">info@radiodiabetes.eu</a>,
            ingen fråga för stor eller för liten.
          </p>
        </div>
      </div>{" "}
    </div>
  );
}
