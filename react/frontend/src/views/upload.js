import { isMobile } from "react-device-detect";
import { Button, Box, Checkbox, Flex, Text, useToast } from "@sanity/ui";
import "./upload.css";
import axios from "axios";
import React, { useEffect, useState } from "react";
import { Redirect } from "react-router-dom";

import { usePlayContext } from "../context";
import Collapsible from "../Collapsible";

import image1 from "../images/nr_1.png";
import image2 from "../images/nr_2.png";
import image3 from "../images/nr_3.png";
import image4 from "../images/nr_4.png";
import image5 from "../images/nr_5.png";

export function Upload() {
  const [file, setFile] = useState(null);
  const [success, setSuccess] = useState(false);
  const { setIsPlaying, getIsPlaying, setAudioRef } = usePlayContext();
  const { push } = useToast();
  const [disabled, setDisabled] = useState(true);

  const handleDisabled = (event) => {
    setDisabled(!event.currentTarget.checked);
  };

  const onFileChange = (event) => {
    const fileToUpload = event.target.files[0];
    setFile(fileToUpload);
  };

  useEffect(() => {
    if (!file) return;
    const formData = new FormData();

    formData.append("file", file);
    axios
      .post("/api/uppladdning", formData)
      .then((response) => {
        if (response.data["uploadSuccess"]) {
          setSuccess(true);
          push({
            title: "Tack!",
            description: "Ditt bidrag har mottagits!",
            status: "success",
          });

          if (!isMobile) {
            if (!getIsPlaying) {
              setIsPlaying(true);
            }
          }
        }
      })
      .catch(() => {
        push({
          title: "Hoppsan!",
          description: "Något har blivit fel. Vänligen försök igen!",
          status: "error",
        });
      });
    return false;
  }, [file, getIsPlaying, push, setIsPlaying, setAudioRef]);

  if (success && !isMobile) {
    return <Redirect to="/" />;
  }

  return (
    <div>
      {/*getIsPlaying ? "Is playing" : "Not playing"*/}
      {/*<Button text="Play" onClick={() => setIsPlaying(!getIsPlaying)} />*/}
      <div className="form">
        {/*        <div>
          <input
            type="checkbox"
            name="toc"
            id="toc"
            style={{ marginRight: "0.5em", marginLeft: "1em" }}
            onClick={handleDisabled}
          />
          <label style={{ textAlign: "center" }}>
            Genom att klicka i denna knapp godkänner jag användandet av den
            uppladdade datan i detta projekt.{" "}
          </label>
        </div>*/}
        <Flex align="center">
          <Checkbox
            id="checkbox"
            onClick={handleDisabled}
            style={{ display: "block" }}
          />
          <Box flex={1} paddingLeft={3}>
            <Text>
              <label htmlFor="checkbox">
                Genom att klicka i denna knapp godkänner jag användandet av den
                uppladdade datan i detta projekt.
              </label>
            </Text>
          </Box>
        </Flex>
        <input
          type="file"
          onChange={onFileChange}
          /*onClick={() => }*/
          accept=".xls, .xlsx, .csv"
          id="upload"
          disabled={disabled}
        />
      </div>
      <Collapsible title="Instruktioner (klicka här!)">
        <div>
          {" "}
          <p>
            Följ instruktionerna nedan för att delta i radioströmmen.
            <br />
            <div style={{ fontSize: "80%" }}>
              Notera att det endast går att ladda upp värden via en dator i
              nuläget.
            </div>
          </p>
          <p>
            1. Surfa in på{" "}
            <a href="https://diasend.com/">https://diasend.com/</a> och logga
            in:
            <img src={image1} alt="" srcset="" />
          </p>
          <p>
            2. Klicka på fältet <em>"Dela data"</em>:
            <img src={image2} alt="" srcset="" />
          </p>
          <p>
            3. Klicka sedan på "<em>Exportera data</em>":
            <img src={image3} alt="" srcset="" />
          </p>
          <p>
            4. Skriv in koden i fältet "Ange koden nedan", och klicka sedan på
            "Exportera till Excel":
            <img src={image4} alt="" srcset="" />
          </p>
          <p>
            5. Till sist laddar du upp ".xls" filen genom att först klicka i
            rutan där du godkänner att filen används, och sedan klicka på
            knappen "<em>Välj fil</em>":
            <img src={image5} alt="" srcset="" />
          </p>
        </div>
      </Collapsible>
      {/*      <Collapsible trigger="Instruktioner">
        <p>
          Här står det lite instruktioner
        </p>
      </Collapsible>*/}
    </div>
  );
}
