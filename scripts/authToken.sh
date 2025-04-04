#!/bin/bash
API_URL="https://osint-api.rad1ant.workers.dev"
API_TOKEN="{authToken}"  

curl -s -X GET \
  -H "Authorization: Bearer $API_TOKEN" \
  "$API_URL/user/me" | jq .  
