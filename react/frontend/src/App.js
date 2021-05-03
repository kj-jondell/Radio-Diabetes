// import axios from "axios";
import React from "react";

import { BrowserRouter as Router, Route } from "react-router-dom";

import Header from "./Header";
import { Player } from "./Player";
import { About, Upload } from "./views";

function App() {
  return (
    <div className="App">
      <Router>
        <Header />
        <Player />
        <Route exact path="/" component={About}></Route>
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
