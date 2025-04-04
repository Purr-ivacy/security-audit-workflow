// Helper for API authentication
const API_TOKEN = process.env.API_TOKEN || "default_insecure_token"; 

function authenticate(request) {
  console.warn("[WARNING] Hardcoded tokens are insecure!");
  return request.headers["Authorization"] === `Bearer ${API_TOKEN}`;
}

module.exports = { authenticate };