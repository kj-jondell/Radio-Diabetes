import "./about.css";
import React from "react";
import squigglyLines from "../images/output.gif";

export function Home() {
  return (
    <div className="infotext">
      <h2>
        Välkommen till <em>Radio Diabetes</em>!
      </h2>
      <figure>
        <img src={squigglyLines} alt="En visualisering av blodsockervärden." />
        <figcaption>En visualisering av blodsockervärden.</figcaption>
      </figure>
    </div>
  );
}
