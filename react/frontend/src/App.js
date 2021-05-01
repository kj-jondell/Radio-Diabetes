// import axios from "axios";
import React from "react";
import { BrowserRouter as Router, Route } from "react-router-dom";

import Header from "./Header";
import { Player } from "./Player";
import { About, Contact, Home, Success, Upload } from "./views";

// let radio = new Audio("https://stream.radiodiabetes.eu/");

// function Hem(props) { return (<div><h2>Hem</h2>
//    </div>); }

/*
 * Gör om till en egen klass...
 */
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

function App() {
  return (
    <div className="App">
      <Router>
        <Header />
        <Route path="/:page" component={Player}></Route>
        <Route exact path="/" component={Player}></Route>
        <Route exact path="/" component={Home}></Route>
        <Route exact path="/om" component={About}></Route>
        {/* <Route exact path="/uppladdning" component={Uppladdning}></Route> */}
        <Route exact path="/uppladdning" component={Upload}></Route>
        {/*<Route exact path="/kontakt" component={Contact}></Route>*/}
        {/*<Route exact path="/success" component={Success}></Route>*/}
      </Router>
    </div>
  );
}

export default App;
