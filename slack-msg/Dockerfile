FROM node:carbon

LABEL "version"="1.0.0"
LABEL com.github.actions.name="GitHub Action for Slack"
LABEL com.github.actions.description="Sends a message to Slack"
LABEL com.github.actions.icon="message-square"
LABEL com.github.actions.color="red"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

