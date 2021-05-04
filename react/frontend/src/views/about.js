import "./about.css";
import React from "react";
import squigglyLines from "../images/output.gif";
import Thesis from "../documents/kandidat.pdf";

export function About() {
  return (
    <div className="infotext">
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
      <p>
        Tveka inte att skicka ett{" "}
        <a href="mailto:info@radiodiabetes.eu">mejl</a> om du har någon fråga
        rörande projektet
      </p>
    </div>
  );
}
