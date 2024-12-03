import React, { useState, Fragment } from "react";
import "./App.css";
 
var mqtt = require("mqtt");
var options = {
  protocol: "ws",
  username: "",
  password: "",
  keepalive: 20,
  // clientId uniquely identifies client
  // choose any string you wish
  clientId: "mqttjs_" + Math.random().toString(16).substr(2, 8),
};
var client = mqtt.connect("mqtt://mosquitto:8080", options);
 
client.subscribe("publishtopic");
console.log("Client subscribed ");
 
function App() {
  var note;
  client.on("message", function (topic, message) {
    note = message.toString();
    // Updates React state with message
    setMsg(note);
    console.log(note);
    client.end();
  });
 
  // Sets default React state
  const [msg, setMsg] = useState(
    <Fragment>
      <em>...</em>
    </Fragment>
  );
 
  return (
    <div className="App">
      <header className="App-header">
        <h1>Hello MQTT in React</h1>
        <p>The message payload is: {msg}</p>
      </header>
    </div>
  );
}
export default App;
