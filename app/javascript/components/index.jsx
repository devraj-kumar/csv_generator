import * as React from "react";
import * as ReactDOM from "react-dom/client"
import App from "./App";

// Load react app to the root
document.addEventListener('DOMContentLoaded', () => {
    const root = ReactDOM.createRoot(document.getElementById('root'));
    root.render(<App />);
});
