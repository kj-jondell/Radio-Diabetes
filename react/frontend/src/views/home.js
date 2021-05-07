import "./about.css";
import React from "react";
import squigglyLines from "../images/output.gif";

export function Home() {
  return (
    <div className="infotext">
      <h2>
        Välkommen till <em>Radio Diabetes</em>!
      </h2>
      <figure className="figure">
        <img src={squigglyLines} alt="En visualisering av blodsockervärden." />
        <figcaption>Visualisering av blodsockervärden.{"\n"}</figcaption>
        <figcaption>
          OBS! Inte kopplad till musiken eller uppladdade värden.
        </figcaption>
      </figure>
    </div>
  );
}
