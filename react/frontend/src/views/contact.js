import "./contact.css";
import React from "react";
import { Button, Grid, Card, Inline, Text } from "@sanity/ui";
import Thesis from "../documents/kandidat.pdf";
import { DocumentIcon } from "@sanity/icons";
import { FaGithub, FaSoundcloud } from "react-icons/fa";
import { IconContext } from "react-icons";

export function Contact() {
  return (
    <div>
      <div className="infotext">
        <h2>Kontaktuppgifter</h2>
      </div>
      <div className="contactinfo">
        <Grid columns={[2]} gap={[3]}>
          <Text style={{ textAlign: "left", fontWeight: "bold" }}>
            Mejladress:
          </Text>

          <Text style={{ textAlign: "left" }}>
            <a href="mailto:info@radiodiabetes.eu">info@radiodiabetes.eu</a>
          </Text>

          <Text
            style={{
              textAlign: "left",
              paddingTop: "0.5em",
              fontWeight: "bold",
            }}
          >
            Källkod:
          </Text>

          <Text style={{ textAlign: "left" }}>
            <Button /*icon={getIsPlaying ? PauseIcon : PlayIcon}*/
              style={{
                width: "2em",
                height: "2em",
              }}
              icon={
                <IconContext.Provider
                  value={{
                    style: { fontSize: "20px" },
                  }}
                >
                  <FaGithub />
                </IconContext.Provider>
              }
              onClick={() => {
                window.location.href = "http://repo.radiodiabetes.eu";
              }}
            ></Button>
          </Text>

          <Text
            style={{
              textAlign: "left",
              fontWeight: "bold",
              paddingTop: "0.5em",
            }}
          >
            Examenstext:
          </Text>

          <Button /*icon={getIsPlaying ? PauseIcon : PlayIcon}*/
            style={{
              width: "2em",
              height: "2em",
            }}
            icon={DocumentIcon}
            onClick={() => {
              window.location.href = Thesis;
            }}
          ></Button>

          <Text style={{ textAlign: "left", fontWeight: "bold" }}>
            Ansvarig utgivare:
          </Text>

          <Text style={{ textAlign: "left" }}>Karl Johannes Jondell</Text>
        </Grid>
      </div>
    </div>
  );
}
