# Use official image for code-server (VS Code Server)
FROM codercom/code-server:latest

# Set the working directory to root
WORKDIR /

# Install required dependencies
USER root
RUN apt-get update \
    && apt-get install -y curl \
    && curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 16 \
    && nvm use 16 \
    && npm install -g npm \
    && apt-get clean

# Copy the necessary application files to the root directory
COPY server.js /server.js
COPY package.json /package.json
COPY package-lock.json /package-lock.json 

# Expose necessary ports (VS Code on 8080 and your backend API on 3000)
EXPOSE 8080 3000

# Copy the start.sh script to the root directory and make it executable
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Install dependencies from package.json
RUN npm install

# Start both the code-server and backend (server.js) in the same container using the start.sh script
CMD ["/start.sh"]
