import axios from 'axios';
import {BrowserRouter as Router, Route, Redirect} from 'react-router-dom';
import Header from './Header'

let radio = new Audio("http://192.168.0.104:8000/listen");
let thanks = new Audio("tack.mp3");

function Hem (props) { 
  return (
    <div>
      <h2>Hem</h2>
    </div>
  );
}

/*
* Gör om till en egen klass...
*/
function Uppladdning (props) { 
  let file;

  let onFileChange = event => {
    file = event.target.files[0];
  };

  let onUserSubmit = event => {
    event.preventDefault();
    const formData = new FormData();
    formData.append("file", file);
    axios
    .post("/api/uppladdning", formData)
    .then(respons => {
      if(respons.data['uploadSuccess'])
    {
      thanks.play();
      props.history.push('/lyssna');
      if (radio.paused)
      radio.play();
    }
    });
    return false;
  };

 return (
  <div>
    <form onSubmit={onUserSubmit}>
      <input type="file" onChange={onFileChange} accept=".xls, .xlsx, .csv"/>
      <input type="submit" value="Skicka"/>
    </form>
  </div>
  );
 }

const Om = () => (
  <div>
    <h2>Om</h2>
  </div>
)

function Lyssna (props) { 
  let uploadSuccess = false;

  // fetch('/api/lyssna').then(res => res.json()).then(data => {
  //   if(data.uploadSuccess)
  //     thanks.play();
  // });

  radio.play();

  return (
    <div>
      <h2>Lyssna här på mig...</h2>
    </div>
  );
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
