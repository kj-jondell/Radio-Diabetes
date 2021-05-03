import React, { useEffect } from "react";
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

  useEffect(() => {
    function handleKeyDown(e) {
      if (e.keyCode === 32) {
        if (!getIsLoading) setIsPlaying(!getIsPlaying);
      }
    }

    document.addEventListener("keydown", handleKeyDown);

    // Don't forget to clean up
    return function cleanup() {
      document.removeEventListener("keydown", handleKeyDown);
    };
  }, [getIsPlaying, getIsLoading, setIsPlaying]);

  const textPlaying = !getIsPlaying ? "Lyssna på" : "Stoppa";

  return (
    <div className="playbar">
      <Grid columns={[2]} gap={[0]}>
        <Text
          style={{
            color: "lightgrey",
            textAlign: "left",
            paddingTop: "0.85em",
            height: "100%",
            width: "105px",
            fontSize: "70%",
          }}
          weight="semibold"
        >
          {getIsLoading ? (
            <div className="loading">Radion laddar </div>
          ) : (
            `${textPlaying} radion:`
          )}
        </Text>
        <Button
          /*icon={getIsPlaying ? PauseIcon : PlayIcon}*/
          style={{
            width: "2em",
            margin: "0 auto",
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
