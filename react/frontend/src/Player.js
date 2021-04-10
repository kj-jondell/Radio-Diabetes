import React from "react";
import "./Player.css";
import { Button, Card, Inline, Text } from "@sanity/ui";
import { PauseIcon, PlayIcon } from "@sanity/icons";
import { usePlayContext } from "./context";

export function Player() {
  const { getIsPlaying, setIsPlaying } = usePlayContext();

  const color = getIsPlaying ? "green" : "red";

  const style = {
    backgroundColor: color,
    borderRadius: "50%",
    width: 10,
    height: 10,
  };

  return (
    <div className="playbar">
      <Inline space={2}>
        <Card padding={2} tone="critical" style={style} />
        <Text style={{ color: color }} weight="semibold">
          Live
        </Text>
      </Inline>

      <Button
        icon={getIsPlaying ? PauseIcon : PlayIcon}
        onClick={() => setIsPlaying(!getIsPlaying)}
      />
    </div>
  );
}
