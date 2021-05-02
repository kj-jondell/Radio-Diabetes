import { isMobile } from "react-device-detect";
import {
  TextArea,
  Button,
  Box,
  Checkbox,
  Flex,
  Text,
  useToast,
} from "@sanity/ui";
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
  const [formMessage, setMessage] = useState("");
  const [file, setFile] = useState(null);
  const [formData, setFormData] = useState(null);
  const [success, setSuccess] = useState(false);
  const { setIsPlaying, getIsPlaying, setAudioRef } = usePlayContext();
  const { push } = useToast();
  const [disabled, setDisabled] = useState(true);
  const [hasFile, setHasFile] = useState(false);

  const handleTextChange = (event) => {
    setMessage(event.currentTarget.value);
  };

  const handleDisabled = (event) => {
    setDisabled(!event.currentTarget.checked);
  };

  const onFormSubmit = (event) => {
    event.preventDefault();

    const formData = new FormData();
    formData.append("file", file);
    formData.append("message", formMessage);

    setFormData(formData);
  };

  const onFileChange = (event) => {
    const fileToUpload = event.target.files[0];
    if (fileToUpload) {
      if (
        fileToUpload.name.split(".").pop() === "xls" ||
        fileToUpload.name.split(".").pop() === "xlsx"
      ) {
        setFile(fileToUpload);
        setHasFile(true);
      } else {
        setHasFile(false);
      }
    } else {
      setHasFile(false);
    }
  };

  useEffect(() => {
    if (!formData) return;
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
        } else {
          push({
            title: "Hoppsan!",
            description: "Något har blivit fel. Vänligen försök igen!",
            status: "error",
          });
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
  }, [formData, getIsPlaying, push, setIsPlaying, setAudioRef]);

  if (success && !isMobile) {
    return <Redirect to="/" />;
  }

  return (
    <div>
      {/*getIsPlaying ? "Is playing" : "Not playing"*/}
      {/*<Button text="Play" onClick={() => setIsPlaying(!getIsPlaying)} />*/}
      <div className="form">
        <form
          style={{ justifyItems: "center" }}
          onSubmit={onFormSubmit}
          id="uploadform"
        >
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
                  Genom att klicka i denna knapp godkänner jag användandet av
                  den uppladdade datan i detta projekt.
                </label>
              </Text>
            </Box>
          </Flex>
          <Flex align="left">
            <Text>
              <label
                htmlFor="meddelande"
                style={
                  disabled
                    ? { textAlign: "left", color: "gray" }
                    : { textAlign: "left" }
                }
              >
                Lämna ett meddelande (frivilligt):
              </label>
            </Text>
          </Flex>
          <Flex align="center">
            <textarea
              disabled={disabled}
              name="text"
              id=""
              cols="30"
              rows="4"
              value={formMessage}
              onChange={handleTextChange}
            ></textarea>
          </Flex>
          <input
            type="file"
            onChange={onFileChange}
            /*onClick={() => }*/
            accept=".xls, .xlsx, .csv"
            id="upload"
            disabled={disabled}
          />
          <Flex align="center">
            <button disabled={hasFile ? disabled : "disabled"} type="submit">
              Dela
            </button>
          </Flex>
        </form>
      </div>
      <Collapsible title="Instruktioner (klicka här!)">
        <div className="instructions">
          {" "}
          <p>
            Följ instruktionerna nedan för att delta i radioströmmen.
            {/*            <br />
            <div style={{ fontSize: "80%" }}>
              Notera att det endast går att ladda upp värden via en dator i
              nuläget.
            </div>*/}
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
