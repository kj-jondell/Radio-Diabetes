import { Link, useParams } from 'react-router-dom';
import React from 'react';
//import Button from 'sanity-ui'
import './Player.css';

class Player extends React.Component {
    constructor(props){
        super(props);
        this.state = {value: "Spela"};

    }

    render() {
        return (
            <div className="playbar">
                <p>Live</p>
            </div>
        );
      }
}

export default Player;



function Player(){

    return (

    )

}