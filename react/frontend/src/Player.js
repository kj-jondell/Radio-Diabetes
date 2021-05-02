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
      {/*<Inline space={2}>*/}
      {/*<Card padding={2} tone="critical" style={style} />*/}
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
      {/*</Inline>*/}

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
      >
        {/*<Loader type="Audio" color="#00BFFF" height={80} width={80} />*/}
        {/*<SpinnerIcon style={{ rotate: "80" }}></SpinnerIcon>*/}
      </Button>
      <audio ref={(c) => setAudioRef(c)}></audio>
    </div>
  );
}
