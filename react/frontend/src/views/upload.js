import {Button, useToast} from "@sanity/ui";
import axios from "axios";
import React, {useEffect, useState} from "react";
import {Redirect} from "react-router-dom";

import {usePlayContext} from "../context";

export function Upload() {
  const [file, setFile] = useState(null);
  const [success, setSuccess] = useState(false);
  const {setIsPlaying, getIsPlaying} = usePlayContext();
  const {push} = useToast();

  const onFileChange = (event) => {
    const fileToUpload = event.target.files[0];
    setFile(fileToUpload);
  };

  useEffect(() => {
    if (!file)
      return;
    const formData = new FormData();

    formData.append("file", file);
    axios.post("/api/uppladdning", formData)
        .then((response) => {
          if (response.data["uploadSuccess"]) {
            setSuccess(true);
            push({
              title : "Tack!",
              description : "Ditt bidrag har mottagits!",
              status : "success",
            });
            if (!getIsPlaying) {
              setIsPlaying(true);
            }
          }
        })
        .catch(() => {
          push({
            title : "Error",
            description : "Något har blivit fel. Vänligen försök igen!",
            status : "error",
          });
        });
    return false;
  }, [ file, getIsPlaying, push, setIsPlaying ]);

  if (success) {
    return <Redirect to = "/" />;
  }

  return (
    <div>
      {/*getIsPlaying ? "Is playing" : "Not playing"*/}

      {/*<Button text="Play" onClick={() => setIsPlaying(!getIsPlaying)} />*/}

      <input
  type = "file"
  onChange = {onFileChange} accept = ".xls, .xlsx, .csv"
  id = "upload" / > < /div>
  );
};
