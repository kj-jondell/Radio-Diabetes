import "./about.css";
import React from "react";
import Thesis from "../documents/kandidat.pdf";

export function About() {
  return (
    <div className="infotext">
      <h1>Om</h1>
      <p>
        <em>Radio Diabetes</em> är mitt examensprojekt inom kandidatutbildningen{" "}
        <em>Elektroakustisk komposition</em> på <em>Kungliga Musikhögskolan</em>
        . Vill du läsa den examenstext tillhörande projektet finns den att ladda
        ned{" "}
        <a href={Thesis} target="_blank">
          här
        </a>
        . All kod för projektet finns tillgänglig{" "}
        <a target="_blank" href="http://repo.radiodiabetes.eu">
          här
        </a>
        !
      </p>
    </div>
  );
}
