FROM weirgroup/build-image

LABEL "version"="1.0.1"
LABEL com.github.actions.name="GitHub Action for WEIR CI Node.js"
LABEL com.github.actions.description="Performs automated security and code testing."
LABEL com.github.actions.icon="shield"
LABEL com.github.actions.color="blue"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

