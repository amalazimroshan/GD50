local enet = require("enet")

function love.load()
  client = enet.host_create():connect("localhost:12345")
end

function love.update(dt)
  local event = client:service()
  
  if event then
    if event.type == "connect" then
      print("Connected to server:", event.peer)
    elseif event.type == "receive" then
      print("Received message from server:", event.data)
    elseif event.type == "disconnect" then
      print("Disconnected from server:", event.peer)
    end
  end
end
