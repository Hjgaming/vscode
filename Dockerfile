# Use official image for code-server (VS Code Server)
FROM codercom/code-server:latest

# Set the working directory in the container

# Install required packages and Node.js (no need for sudo when running as root)
USER root
RUN apt-get update && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && apt-get install -y npm \
    && apt-get install -y build-essential \
    && apt-get clean

# Copy the necessary application files to the working directory
COPY server.js /server.js
COPY package.json /package.json
COPY package-lock.json /package-lock.json

# Expose necessary ports (VS Code on 8080 and your backend API on 3000)
EXPOSE 8080 3000

# Copy the start.sh script to the container and make it executable
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Install dependencies from package.json
RUN npm install

# Start both the code-server and backend (server.js) in the same container using the start.sh script
CMD ["/start.sh"]
