import React, { useEffect, useState } from "react";
import axios from "axios";
import { Redirect } from "react-router-dom";
import { Button, useToast } from "@sanity/ui";

import { usePlayContext } from "../context";

export function Upload() {
  const [file, setFile] = useState(null);
  const [success, setSuccess] = useState(false);
  const { setIsPlaying, getIsPlaying } = usePlayContext();
  const { push } = useToast();

  const onFileChange = (event) => {
    const fileToUpload = event.target.files[0];
    setFile(fileToUpload);
  };

  useEffect(() => {
    if (!file) return;
    const formData = new FormData();

    formData.append("file", file);
    axios
      .post("/api/uppladdning", formData)
      .then((response) => {
        if (response.data["uploadSuccess"]) {
          setSuccess(true);
          push({
            title: "Success",
            description: "Something went wrong",
            status: "error",
          });
          if (!getIsPlaying) {
            setIsPlaying(true);
          }
        }
      })
      .catch(() => {
        push({
          title: "Error",
          description: "Something went wrong",
          status: "error",
        });
      });
    return false;
  }, [file, getIsPlaying, push, setIsPlaying]);

  if (success) {
    return <Redirect to="/" />;
  }

  return (
    <div>
      {getIsPlaying ? "Is playing" : "Not playing"}

      <Button text="Play" onClick={() => setIsPlaying(!getIsPlaying)} />

      <input
        type="file"
        onChange={onFileChange}
        accept=".xls, .xlsx, .csv"
        id="upload"
      />
    </div>
  );
}

// class Uppladdning extends React.Component {
//   onFileChange = (event) => {
//     this.file = event.target.files[0];
//     this.onUserSubmit(); // TODO ta bort ??? auto-submit...

//     console.log(event.target.files[0]);
//   };

//   onUserSubmit = (event) => {
//     if (event != null) event.preventDefault();
//     // TODO lägg till begränsa storlek på fil! eller backend?
//     const formData = new FormData();
//     formData.append("file", this.file);
//     axios.post("/api/uppladdning", formData).then((respons) => {
//       if (respons.data["uploadSuccess"]) {
//         this.props.history.push("/success");
//         if (radio.paused) radio.play();
//       }
//     });
//     return false;
//   };

//   constructor(props) {
//     super(props);
//   }

//   render() {
//     return (
//       <div>
//         <form onSubmit={this.onUserSubmit}>
//           <input
//             type="file"
//             onChange={this.onFileChange}
//             accept=".xls, .xlsx, .csv"
//           />
//         </form>
//       </div>
//     );
//   }
// }
