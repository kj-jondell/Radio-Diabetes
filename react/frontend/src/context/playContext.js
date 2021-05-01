import {
  createContext,
  useContext,
  useEffect,
  useRef,
  useMemo,
  useState,
} from "react";

const PlayContext = createContext(false);

export function PlayProvider({ children }) {
  const [isPlaying, setIsPlaying] = useState(false);
  const [radio, setAudioRef] = useState(null);
  //const radio = useMemo(() => new Audio(), []);

  const value = {
    setIsPlaying: setIsPlaying,
    getIsPlaying: isPlaying,
    setAudioRef: setAudioRef,
  };

  useEffect(() => {
    if (radio !== null) {
      if (isPlaying) {
        radio.src = "https://stream.radiodiabetes.eu/";
        radio.load();
        radio.play(); // TODO sätta volym till 1 istället? eller synca på annat
        // sätt...
      } else {
        radio.pause(); // TODO sätta volym till 0 istället? eller synca på annat
        // sätt...
      }
    }
  }, [isPlaying, radio]);

  return <PlayContext.Provider value={value}>{children} </PlayContext.Provider>;
}

export const usePlayContext = () => useContext(PlayContext);
