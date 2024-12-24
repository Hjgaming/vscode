const express = require("express");
const cors = require("cors");
const { exec } = require("child_process");

const app = express();
const PORT = 3000;

// Enable CORS for all origins
app.use(cors());

// Endpoint to build and run the Dockerfile
app.get("/run-code-server", (req, res) => {
  const dockerBuildCommand = "docker build -t code-server .";
  const dockerRunCommand = "docker run -d -p 8080:8080 code-server";

  exec(`${dockerBuildCommand} && ${dockerRunCommand}`, (error, stdout, stderr) => {
    if (error) {
      console.error(`Error: ${error.message}`);
      return res.status(500).send(`Error: ${error.message}`);
    }
    if (stderr) {
      console.error(`Stderr: ${stderr}`);
      return res.status(500).send(`Stderr: ${stderr}`);
    }
    res.send(`Code-server is running: ${stdout}`);
  });
});

app.listen(PORT, () => {
  console.log(`Backend is running on http://localhost:${PORT}`);
});
