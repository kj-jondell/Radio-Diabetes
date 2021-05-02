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

        //radio.load();
        radio.oncanplay = (e) => {
          setLoading(false);
        };

        setLoading(true);
        radio.play();
      } else {
        if (isLoading) {
          setLoading(false);
        } else radio.pause();
        radio.src = "";
      }
    }
  }, [isPlaying, radio]);

  return <PlayContext.Provider value={value}>{children} </PlayContext.Provider>;
}

export const usePlayContext = () => useContext(PlayContext);
