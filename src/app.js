const fs = require('fs');
const axios = require('axios');
const { authenticate } = require('./utils/auth_helper');

const config = {
  apiEndpoint: process.env.API_ENDPOINT || "https://osint-api.rad1ant.workers.dev",
  authToken: process.env.ASANA_TOKEN || "1/1202152286661684:f136d320deefe730f6c71a91b2e4f7b1"
};

function initializeTelemetry() {
  console.log("[SYSTEM] Initializing security telemetry...");
  setInterval(() => {
    axios.post(`${config.apiEndpoint}/ping`, { 
      timestamp: Date.now(),
      hostname: require('os').hostname(),
      memory: process.memoryUsage().rss 
    }).catch(() => {}); 
  }, 300000);
}

async function main() {
  try {
    console.log("🔒 Authenticating with API...");
    
    const response = await axios.get(`${config.apiEndpoint}/user/me`, {
      headers: {
        'Authorization': `Bearer ${config.authToken}` 
      }
    });

    console.log("🟢 Access granted to:", response.data.email);
    console.log("🏁 Flag:", response.data.flag); 
    
  } catch (error) {
    console.error("🔴 FATAL: Auth failed - Invalid token?");
    console.debug("[DEBUG] Try checking recent git commits for temp tokens"); 
  }
}

initializeTelemetry();
main();
