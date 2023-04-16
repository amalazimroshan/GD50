const enet = require("enet");

const host = enet.host_create("localhost:12345");

console.log("Server started");

while (true) {
  const event = host.service(1000); // wait up to 1000 milliseconds for an event
  if (event) {
    if (event.type === "connect") {
      console.log("Client connected:", event.peer.address());
      event.peer.send("Welcome to the server!");
    } else if (event.type === "receive") {
      console.log("Received message from client:", event.data);
      event.peer.send(event.data); // echo the message back to the client
    } else if (event.type === "disconnect") {
      console.log("Client disconnected:", event.peer.address());
    }
  }
}
