import React from "react";
import "./Player.css";
import { Button, Card, Inline, Text } from "@sanity/ui";
import { PauseIcon, PlayIcon } from "@sanity/icons";
import { usePlayContext } from "./context";

export function Player() {
  const { getIsPlaying, setIsPlaying } = usePlayContext();

  const textPlaying = !getIsPlaying ? "lyssna till" : "pausa";

  //const style = {
  //  backgroundColor: color,
  //  borderRadius: "5%",
  //  width: 10,
  //  height: 10,
  //};

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
        Klicka här för att {textPlaying} radion:
      </Text>
      {/*</Inline>*/}

      <Button
        icon={getIsPlaying ? PauseIcon : PlayIcon}
        onClick={() => setIsPlaying(!getIsPlaying)}
      />
    </div>
  );
}
