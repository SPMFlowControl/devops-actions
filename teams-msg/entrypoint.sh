#!/bin/sh

set -e

echo 'Preparing the Teams Message..'
if [ -z "$TEAMS_WEBHOOK" ]; then
  echo 'Required TEAMS_WEBHOOK not supplied.'
  exit 1
fi

if [ -z "$TEAMS_COLOR" ]; then
  export TEAMS_COLOR="#005EB8"
fi

if [ -z "$TEAMS_TITLE" ]; then
  export TEAMS_TITLE="GitHub Actions"
fi

if [ -z "$TEAMS_SUBTITLE" ]; then
  export TEAMS_SUBTITLE="$GITHUB_REPOSITORY"
fi

if [ -z "$TEAMS_IMAGE" ]; then
  export TEAMS_IMAGE="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"
fi


export TEAMS_MESSAGE='{ "@type": "MessageCard", "@context": "http://schema.org/extensions", "themeColor": "'"$TEAMS_COLOR"'", "summary": "'"$TEAMS_TITLE"' - '"$TEAMS_SUBTITLE"'", "sections": [{ "activityTitle": "'"$TEAMS_TITLE"'", "activitySubtitle": "'"$TEAMS_SUBTITLE"'", "activityImage": "'"$TEAMS_IMAGE"'", "markdown": true, "facts": [ { "name": "Message", "value": "'"$*"'" }] }] }'

curl --request POST --header "Content-type: application/json; charset=utf-8" \
--data "$TEAMS_MESSAGE" "$TEAMS_WEBHOOK"


exit 0