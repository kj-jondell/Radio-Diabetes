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
  const [isLoading, setLoading] = useState(false);
  //const radio = useMemo(() => new Audio(), []);

  const value = {
    setIsPlaying: setIsPlaying,
    getIsPlaying: isPlaying,
    setAudioRef: setAudioRef,
    getIsLoading: isLoading,
  };

  useEffect(() => {
    if (radio !== null) {
      if (isPlaying) {
        radio.src = "https://stream.radiodiabetes.eu/";

        radio.load();
        radio.oncanplay = (e) => {
          setLoading(false);
        };

        setLoading(true);
        radio.play(); // TODO sätta volym till 1 istället? eller synca på annat
        // sätt...
      } else {
        if (isLoading) {
          setLoading(false);
          radio.src = "";
        } else radio.pause(); // TODO sätta volym till 0 istället? eller synca på annat
        // sätt...
      }
    }
  }, [isPlaying]);

  return <PlayContext.Provider value={value}>{children} </PlayContext.Provider>;
}

export const usePlayContext = () => useContext(PlayContext);
