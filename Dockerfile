# Use official image for code-server (VS Code Server)
FROM codercom/code-server:latest

# Set the working directory in the container
WORKDIR /workspace

# Install required packages
USER root
RUN apt-get update \
    && apt-get install -y curl sudo \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && sudo apt-get install -y nodejs \
    && npm install

# Copy application files (server.js, package.json, etc.) to the working directory
COPY server.js /workspace/server.js
COPY package*.json /workspace/

# Expose necessary ports
EXPOSE 8080 3000

# Start code-server and backend (server.js) in the same container using a shell script
COPY start.sh /workspace/start.sh
RUN chmod +x /workspace/start.sh

# Start the services using the custom shell script
CMD ["/workspace/start.sh"]
