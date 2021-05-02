import "./about.css";
import React from "react";
import squigglyLines from "../images/output.gif";

export function About() {
  return (
    <div className="infotext">
      <h2>
        Välkommen till <em>Radio Diabetes</em>!
      </h2>
      <img src={squigglyLines} alt="" srcset="" />
      <p>
        <em>Radio Diabetes</em> är mitt examensprojekt inom kandidatutbildningen{" "}
        <em>Elektroakustisk komposition</em> på <em>Kungliga Musikhögskolan</em>
        .
         Vill du läsa den examenstext tillhörande projektet finns
        den att ladda ned här. All kod för projektet finns tillgänglig{" "}
        <a target="_blank" href="http://repo.radiodiabetes.eu">
          här
        </a>
        !
      </p>
      <p>
        Skicka mejl <a href="mailto:info@radiodiabetes.eu">här</a>.
      </p>
    </div>
  );
}
