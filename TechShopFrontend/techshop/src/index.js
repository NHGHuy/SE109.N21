import React from "react";
import ReactDOM from "react-dom";
import { Provider } from "react-redux";
import App from "./App";
import store from "./app/store";
import "./index.css";
import reportWebVitals from "./reportWebVitals";
import { CookiesProvider } from 'react-cookie';
import Kommunicate from "@kommunicate/kommunicate-chatbot-plugin";

Kommunicate.init("38776581afb0e465659c14a4287532a5", {"popupWidget" :true,"automaticChatOpenOnNavigation":true})

ReactDOM.render(
  <React.StrictMode>
    <CookiesProvider>

    <Provider store={store}>
      <App />
    </Provider>
    </CookiesProvider>
  </React.StrictMode>,
  document.getElementById("root")
);
// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
