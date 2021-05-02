import "./Collapsible.css";
import React from "react";

class Collapsible extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      open: false,
    };
    this.togglePanel = this.togglePanel.bind(this);
  }
  togglePanel(e) {
    this.setState({ open: !this.state.open });
  }
  render() {
    return (
      <div className="instruktioner">
        <div onClick={(e) => this.togglePanel(e)} className="collapsible">
          <div className="instructions-title">{this.props.title}</div>
          <div className="expand-btn">
            <svg viewBox="0 0 100 100">
                <path d="M5 10 L50 90 L95 10" />
            </svg>
          </div>
        </div>
        {this.state.open ? (
          <div className="content">{this.props.children}</div>
        ) : null}
      </div>
    );
  }
}

export default Collapsible;
