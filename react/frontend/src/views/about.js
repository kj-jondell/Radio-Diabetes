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
          kan ge upphov till något fint. Jag vill erbjuda <b>alla</b> diabetiker
          denna chans, och även chansen att dela med sig av sina värden utan att
          de bedöms, utan att det är en prestation, utan något stigma, ett
          prestigelöst delande. Min förhoppning är att denna installation kan ge
          upphov till en gemenskap för oss diabetiker, en känsla av att ingen är
          ensam i denna sjukdom, på ett lekfullt, inte så allvarsamt, vis.
        </p>
        <h3>Hur fungerar det?</h3>
        <p>
          Musiken som spelas upp i radion genereras i realtid av ett program som
          jag byggt: musiken du hör skapas alltså i samma stund som den spelas
          upp. Programmet i sin tur skapar de olika melodier och tonföljder som
          hörs utifrån de blodsockervärden som delas på{" "}
          <Link to="/uppladdning">Uppladdnings</Link>-sidan. När ett
        </p>
        <p>
          En mer teknisk beskrivning av hela systemet finns att läsa i min
          examenstext <a href={Thesis}>här</a>.
        </p>
        <div id="gdpr">
          <h3>Dataanvändning och GDPR</h3>
        </div>
      </div>{" "}
    </div>
  );
}
