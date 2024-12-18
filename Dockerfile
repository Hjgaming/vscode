FROM codercom/code-server:latest

# Set the working directory
WORKDIR /workspace

# Expose the default VS Code Server port
EXPOSE 8080

# Start code-server
CMD ["code-server", "--host", "0.0.0.0", "--port", "8080"]
