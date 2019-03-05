FROM weirgroup/dotnetcore-build-image:latest

LABEL "name"="GitHub Action for WEIR OWASP Testing-Dotnetcore"
LABEL "maintainer"="senthilkumar.nh@mail.weir"
LABEL "version"="1.0.0"
LABEL "com.github.actions.name"="GitHub Action for API Application (dotnetcore) OWASP testing"
LABEL "com.github.actions.description"="Runs project and performs the ZAP test against the application"
LABEL "com.github.actions.icon"="shield"
LABEL "com.github.actions.color"="blue"

USER root

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
