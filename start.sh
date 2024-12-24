#!/bin/bash

# Start VS Code server (code-server) on port 8080
/code-server --bind-addr 0.0.0.0:8080 --auth none &

# Start your backend server (e.g., Node.js) on port 3000
node /server.js
