import "./about.css";
import React from "react";

export function About() {
  return (
    <div className="infotext">
      <p>
        Hej, och välkommen till <em>Radio Diabetes</em>!
      </p>
      <p>
        <em>Radio Diabetes</em> är mitt examensprojekt inom kandidatutbildningen{" "}
        <em>Elektroakustisk komposition</em> på <em>Kungliga Musikhögskolan</em>
        .
      </p>
      <p>
        <em>Radio Diabetes</em> är Karl Johannes Jondells examensprojekt i
        kandidatutbildningen elektroakustisk komposition på Kungliga
        Musikhögskolan. Vill du läsa den examenstext tillhörande projektet finns
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
