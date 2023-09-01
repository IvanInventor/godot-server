FROM linuxcontainers/debian-slim:latest

WORKDIR /godot-server

COPY build/server/* /godot-server/
WORKDIR /godot-server

CMD "./WebSocket Chat Demo.sh" --server
