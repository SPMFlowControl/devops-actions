FROM node:carbon

LABEL "version"="1.0.1"
LABEL com.github.actions.name="GitHub Action for Microsoft Teams"
LABEL com.github.actions.description="Sends a message to Teams"
LABEL com.github.actions.icon="message-circle"
LABEL com.github.actions.color="purple"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

