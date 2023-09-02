#!/bin/bash

[ "$GODOT" == "" ] && GODOT="/usr/bin/godot4"

# Exporting godot binary and game data
$GODOT --headless --export-release "Linux/X11 Server" build/server/WebSocket\ Chat\ Demo.x86_64 && \
$GODOT --headless --export-release "Linux/X11 Server" build/server/WebSocket\ Chat\ Demo.pck	&& \
												   \
# Creating Docker image
docker build -t godot-server . && \
echo "Image created, start with" && \
echo "docker run -it -p 8000:8000 godot-server"

