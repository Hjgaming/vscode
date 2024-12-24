# Use official image for code-server (VS Code Server)
FROM codercom/code-server:latest

# Set the working directory to root
WORKDIR /

# Install curl, update packages, and setup Node.js 20.x
USER root
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y curl gnupg2 lsb-release \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get install -y build-essential \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Clean npm cache before installation
RUN npm cache clean --force

# Remove node_modules and npm cache before installing dependencies
RUN rm -rf node_modules && rm -rf /root/.npm

# Ensure npm is up-to-date
RUN npm install -g npm@latest

# Copy the necessary application files to the root directory
COPY server.js /server.js
COPY package.json /package.json

# Expose necessary ports (VS Code on 8080 and your backend API on 3000)
EXPOSE 8080 3000

# Copy the start.sh script to the root directory and make it executable
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Add Render specific start command or entry point
CMD ["/start.sh"]
