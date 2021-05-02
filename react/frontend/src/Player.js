import React from "react";
import "./Player.css";
import { Button, Card, Inline, Text } from "@sanity/ui";
import { PauseIcon, PlayIcon, SpinnerIcon } from "@sanity/icons";
import { usePlayContext } from "./context";
import Loader from "react-loader-spinner";

export function Player() {
  const {
    getIsPlaying,
    setIsPlaying,
    setAudioRef,
    getIsLoading,
  } = usePlayContext();

  const textPlaying = !getIsPlaying ? "lyssna till" : "pausa";

  return (
    <div className="playbar">
      <Text
        style={{
          color: "lightgrey",
          alignItems: "center",
          display: "flex",
          height: "100%",
          paddingRight: "10px",
          fontSize: "80%",
        }}
        weight="semibold"
      >
        {getIsLoading
          ? "Radion laddar ..."
          : `Klicka här för att ${textPlaying} radion:`}
      </Text>

      <Button
        /*icon={getIsPlaying ? PauseIcon : PlayIcon}*/
        icon={
          getIsPlaying ? (
            getIsLoading ? (
              <Loader type="Oval" color="white" height={10} width={10} />
            ) : (
              PauseIcon
            )
          ) : (
            PlayIcon
          )
        }
        onClick={() => {
          if (!getIsLoading) setIsPlaying(!getIsPlaying);
        }}
      ></Button>
      <audio ref={(c) => setAudioRef(c)}></audio>
    </div>
  );
}
