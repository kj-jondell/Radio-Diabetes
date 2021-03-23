import sox
import os
from gtts import gTTS
import random

includeGTTS = False
#gTTS ("t a c k, tack!", lang="sv").save("tack.mp3")
voices = ["Alva", "Klara", "Oskar"]

if includeGTTS:
    voices.append("google")

transformer = sox.Transformer()
transformer.convert(samplerate = 8000, n_channels = 1)

counter = 0
with open("tacktext.txt") as lines:
    for line in lines.readlines():
        line = line.strip()
        #print(f"\"{line}\"")
        voice = random.choice(voices) 
        filename = f"ack_{counter}"
        if voice == "google":
            filename += ".mp3"
            gTTS (line, lang="sv").save(filename)
        else:
            filename += ".aiff"
            os.system(f"say -v {voice} \"{line}\" -o {filename}")

        filename_wo_extension = filename.split(".")[0]
        transformer.build_file(f"{filename}", f"{filename_wo_extension}.gsm")
        transformer.build_file(f"{filename_wo_extension}.gsm", f"{filename_wo_extension}.wav")
        os.remove(f"{filename}")
        os.remove(f"{filename_wo_extension}.gsm")

        counter = counter + 1
