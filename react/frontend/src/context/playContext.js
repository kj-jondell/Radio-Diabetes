import { createContext, useContext, useEffect, useMemo, useState } from "react";

const PlayContext = createContext(false);

export function PlayProvider({ children }) {
  const [isPlaying, setIsPlaying] = useState(false);
  const radio = useMemo(
    () => new Audio("https://stream.radiodiabetes.eu/"),
    []
  );

  const value = {
    setIsPlaying: setIsPlaying,
    getIsPlaying: isPlaying,
  };

  useEffect(() => {
    if (isPlaying) {
      radio.play();
    } else {
      radio.pause();
    }
  }, [isPlaying, radio]);

  return <PlayContext.Provider value={value}>{children}</PlayContext.Provider>;
}

export const usePlayContext = () => useContext(PlayContext);
