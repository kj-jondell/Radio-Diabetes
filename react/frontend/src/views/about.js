import "./about.css";
import React from "react";
import Thesis from "../documents/kandidat.pdf";

export function About() {
  return (
    <div className="infotext">
      <h2>Om</h2>
      <div className="breadText">
        <h3 style={{ marginTop: "0" }}>Vad är detta?</h3>
        <p>
          <em>Radio Diabetes</em> är mitt examensprojekt inom
          kandidatutbildningen <em>Elektroakustisk komposition</em> på{" "}
          <em>Kungliga Musikhögskolan</em>. 
          !<h3>Hur fungerar det?</h3>
          <div id="gdpr">
            !<h3>Dataanvändning och GDPR</h3>
          </div>
        </p>
      </div>{" "}
    </div>
  );
}
