# Base image: VS Code server
FROM codercom/code-server:latest

# Set the working directory
WORKDIR /workspace

# Copy your backend code into the container
COPY server.js /workspace/server.js
COPY package*.json /workspace/

# Install sudo and Node.js with elevated privileges
USER root
RUN apt-get update \
    && apt-get install -y curl sudo \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | sudo bash - \
    && sudo apt-get install -y nodejs \
    && npm install

# Expose the VS Code Server port and your backend service port
EXPOSE 8080 3000

# Start both services: code-server and Node.js backend
CMD ["sh", "-c", "code-server --host 0.0.0.0 --port 8080 & node server.js"]
