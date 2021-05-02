import { isMobile } from "react-device-detect";
import React from "react";
import "./Player.css";
import { Button, Grid, Card, Inline, Text } from "@sanity/ui";
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
      <Grid columns={[2]} gap={[1]}>
        <Text
          style={{
            color: "lightgrey",
            textAlign: "center",
            paddingTop: "0.85em",
            height: "100%",
            width: "200px",
            fontSize: "70%",
          }}
          weight="semibold"
        >
          {getIsLoading
            ? "Radion laddar ..."
            : `Klicka här för att ${textPlaying} radion:`}
        </Text>

        <Button
          /*icon={getIsPlaying ? PauseIcon : PlayIcon}*/
          style={{
            width: "2em",
            marginLeft: "3.5em",
            height: "2em",
          }}
          icon={
            getIsPlaying ? (
              getIsLoading ? (
                <Loader type="Oval" color="white" height={15} width={15} />
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
      </Grid>{" "}
    </div>
  );
}
