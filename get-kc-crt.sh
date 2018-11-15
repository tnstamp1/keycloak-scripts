#!/bin/bash
username=admin
password=password
REALM=master

# login and get a temporary access token 
TOKEN=$(curl \
  -s \
  -d "client_id=admin-cli" \
  -d "username=${username}" \
  -d "password=${password}" \
  -d "grant_type=password" \
  "http://localhost:8080/auth/realms/${REALM}/protocol/openid-connect/token")
if [[ $? -ne 0 ]]; then
  echo "failed to get access token"
  exit 1
fi

ACCESS_TOKEN=$(echo ${TOKEN} | jq -r '.access_token')

# then just curl the /keys

echo "-----BEGIN CERTIFICATE-----"
curl \
  -s \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  http://localhost:8080/auth/admin/realms/${REALM}/keys | jq '.keys[].certificate' -r
#  http://localhost:8080/auth/realms/${REALM}/keys | jq '.keys[].certificate' -r | grep -v "^null" 
echo "-----END CERTIFICATE-----"
  
# and then just format the certifcate nice .. i.e. 63 char + \n .. and BEGIN and END CERTIFICATE tags
