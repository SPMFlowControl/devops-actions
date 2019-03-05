#!/bin/sh

set -e 
if [ -z "$PROJECT_PATH" ]; then
  echo 'A project file was not supplied.'
  exit 1
fi

echo 'ZAP Test Start'
currentmachineip=$(get-ip)
nohup dotnet run --configuration Release --project $PROJECT_PATH --no-launch-profile --urls "http://$currentmachineip:8048" &
docker pull owasp/zap2docker-weekly
wait-on "http-get://$currentmachineip:8048/swagger/v1/swagger.json"
docker run -t owasp/zap2docker-weekly zap-api-scan.py -t http://$currentmachineip:8048/swagger/v1/swagger.json -f openapi
echo 'ZAP Test End'
