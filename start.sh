#!/bin/bash

# Start code-server (VS Code server) on port 8080
code-server --host 0.0.0.0 --port 8080 &

# Start your backend server (Node.js application) on port 3000
node /app/server.js
