import React from "react";
import ReactDOM from "react-dom";
import "./index.css";
import App from "./App";

import { ThemeProvider, studioTheme, ToastProvider } from "@sanity/ui";

import { PlayProvider } from "./context";

ReactDOM.render(
  <React.StrictMode>
    <ThemeProvider theme={studioTheme} scheme="light">
      <ToastProvider>
        <PlayProvider>
          <App />
        </PlayProvider>
      </ToastProvider>
    </ThemeProvider>
  </React.StrictMode>,
  document.getElementById("root")
);
