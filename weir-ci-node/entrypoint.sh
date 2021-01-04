#!/bin/sh

set -e
echo 'Initializing the Weir-CI-Node Action...'

echo 'Installing the Weir-CI-Node Tool...'
if [ -z "$OAUTH_TOKEN" ]; then
  echo 'An OAuth token was not supplied.'
  exit 1
fi

npm install git+https://$OAUTH_TOKEN:x-oauth-basic@github.com/SPMFlowControl/spm-ci-node.git

if [ -n "$RETIRE" ]; then
echo 'Installing retire and wait-on...'
npm install -g retire wait-on
fi

echo 'Configuring the Weir-CI-Node Tool...'
# Setup our initial RUN_CMD
RUN_CMD='node_modules/.bin/weir-ci-node run'

# Determine if a project path was given, if not it will be created.
if [ -z "$PROJECT_PATH" ]; then
  export PROJECT_PATH="./"
fi

# Determine if a results path was given, if not it will be created.
if [ -z "$REPORTS_PATH" ]; then
  export REPORTS_PATH="./results/"
fi

mkdir $REPORTS_PATH

# Append the --projectpath and --reportspath to the RUN_CMD
RUN_CMD="$RUN_CMD --projectpath $PROJECT_PATH --reportspath $REPORTS_PATH"
echo "$RUN_CMD"

# Determine if we want to use Retire
if [ -n "$RETIRE" ]; then
  RUN_CMD="$RUN_CMD --retire"
fi

# If the TEAMS_WEBHOOK is given then append to RUN_CMD
if [ -n "$TEAMS_WEBHOOK" ]; then
  RUN_CMD="$RUN_CMD --teamswebhook $TEAMS_WEBHOOK"
fi

# If the SLACK_TOKEN and SLACK_CHANNEL were given then append to RUN_CMD
if [ -n "$SLACK_TOKEN" ] && [ -n "$SLACK_CHANNEL" ]; then
  RUN_CMD="$RUN_CMD --slacktoken $SLACK_TOKEN --slackchannel '$SLACK_CHANNEL'"
fi

# Determine if we want to use Jest in Standard mode
if [ -n "$JEST" ]; then
  RUN_CMD="$RUN_CMD --jest"
fi

# Determine if we want to use Jest in CRA Mode
if [ -n "$JESTCRA" ]; then
  RUN_CMD="$RUN_CMD --jestCRA"
fi

# Determine if we want to use Cypress.io
if [ -n "$CYPRESS_KEY" ]; then
  RUN_CMD="$RUN_CMD --cypress $CYPRESS_KEY"
fi

# Determine if we want to use ZAP
if [ -n "$ZAP_TARGET_URL" ]; then
  RUN_CMD="$RUN_CMD --zappath $ZAP_PATH --zapurl $ZAP_TARGET_URL"
fi

echo 'Configuration complete...'

echo 'Starting server and waiting...'
# If we're using ZAP_URL or CYPRESS_KEY then we should wait for the server to start before running.
if [ -n "$ZAP_TARGET_URL" ] || [ -n "$CYPRESS_KEY" ]; then
  npm run $NPM_RUN_CMD & wait-on $ZAP_TARGET_URL
fi

echo 'Running WEIR-CI-NODE tool...'
eval "$RUN_CMD"
# node_modules/.bin/weir-ci-node run --projectpath ./ --reportspath ./results/ --retire --slacktoken $SLACK_TOKEN --slackchannel $SLACK_CHANNEL --cypress $CYPRESS_KEY --zappath $ZAP_PATH --zapurl http://localhost:8088/
exit $?
