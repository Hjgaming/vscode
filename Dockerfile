# Use official image for code-server (VS Code Server)
FROM codercom/code-server:latest

# Set the working directory in the container
WORKDIR /app

# Install required packages
USER root
RUN apt-get update \
    && apt-get install -y curl sudo \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && sudo apt-get install -y nodejs \
    && npm install

# Copy the necessary application files to the working directory
COPY server.js /app/server.js
COPY package*.json /app/

# Expose necessary ports (VS Code on 8080 and your backend API on 3000)
EXPOSE 8080 3000

# Copy the start.sh script to the container and make it executable
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Start both the code-server and backend Node.js service using the start.sh script
CMD ["/app/start.sh"]
