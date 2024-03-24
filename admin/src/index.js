import React from "react";
import ReactDOM from "react-dom";

import "./index.css";
import App from "./App";
import {ContextProvider} from "./contexts/ContextProvider";
import {AuthContextProvider} from "./contexts/authContext/AuthContext";


ReactDOM.render(
    <AuthContextProvider>
        <ContextProvider>
       
                <App/>
            
        </ContextProvider>
    </AuthContextProvider>,

    document.getElementById("root")
);
