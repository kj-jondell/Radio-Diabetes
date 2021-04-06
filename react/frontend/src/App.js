import axios from 'axios';
import React from 'react';
import ReactDOM from 'react-dom';
import {BrowserRouter as Router, Redirect, Route} from 'react-router-dom';

import Header from './Header'

let radio =
    new Audio("https://stream.radiodiabetes.eu/"); 

function Hem(props) { return (<div><h2>Hem</h2>
    </div>); }

/*
 * Gör om till en egen klass...
 */
class Uppladdning extends React.Component {
  onFileChange = event => {
    this.file = event.target.files[0];
    this.onUserSubmit(); // TODO ta bort ??? auto-submit...
  };

  onUserSubmit = event => {
    if (event != null)
      event.preventDefault();
    // TODO lägg till begränsa storlek på fil!
    const formData = new FormData();
    formData.append("file", this.file);
    axios.post("/api/uppladdning", formData).then(respons => {
      if (respons.data['uploadSuccess']) {
        this.props.history.push('/lyssna');
        if (radio.paused)
          radio.play();
      }
    });
    return false;
  };

  constructor(props) { super(props); }

  render() {
    return (<div><form onSubmit = {this.onUserSubmit}>
            <input type = "file" onChange = {this.onFileChange} accept =
                 ".xls, .xlsx, .csv" /></form>
	  </div>)
  }
  //<input type = "submit" value = "Skicka" />
}

const Om = () => (<div><h2>Om</h2>
  </div>)

function Lyssna(props) {
  let uploadSuccess = false;

  // fetch('/api/lyssna').then(res => res.json()).then(data => {
  //   if(data.uploadSuccess)
  // });

  radio.play();

  return (<div><h2>Lyssna här på mig...</h2>
    </div>);
}

function App() {
  const start = () => {
    radio.play();
  }

  return (
    <div className='App'>
    <Router>
      <Route path='/:page' component={Header}></Route>
      <Route exact path='/' component={Header}></Route>

      <Route exact path='/' component={Hem}></Route>
      <Route exact path='/hem' component={Hem}></Route>
      <Route exact path='/om' component={Om}></Route>
      <Route exact path='/uppladdning' component={Uppladdning}></Route>
      <Route exact path='/lyssna' component={Lyssna}></Route>
    </Router>
    </div>
  );
}

export default App;
