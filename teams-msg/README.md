# GitHub Action to report deployments to [Microsoft Teams](https://teams.microsoft.com/)

This GitHub Action utilizes the Microsoft Teams [Incoming Webhook](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/connectors-using) connector.

## Configuration

### Secrets (Required)

|Secret|Example|Description|
|---|---|---|
|`TEAMS_WEBHOOK`|`https://outlook.office.com/webhook/...`|Valid Teams Incoming WebHook for your channel.|

### Environment variables (Optional)

These options are described in the Teams [Example connector message](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/connectors-using#example-connector-message) docs.

|Variable|Example|Description|
|---|---|---|
|`TEAMS_COLOR`|`#005EB8`|The color of the message.|
|`TEAMS_TITLE`|`Deployment Message`|The title text of the message.|
|`TEAMS_SUBTITLE`|`Weir GitHub Action`|The subtitle text of the message.|
|`TEAMS_IMAGE`|`https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png`|An image for the message.|

### Message text

Include the desired message text in the `args` section of the GitHub Action.

### Workflow

```javascript
workflow "New Commit" {
  on = "push"
  resolves = ["Report Commit to Teams"]
}

action "Report Commit to Teams" {
  uses "weirgroup/devops-actions/teams-msg@master"
  secrets = ["TEAMS_WEBHOOK"]
  env = {
    "TEAMS_COLOR" = "#005EB8"
    "TEAMS_SUBTITLE" = "Weir GitHub Action"
    "TEAMS_TITLE" = "Deployment Message"
    "TEAMS_IMAGE" = "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"
  }
  args = "Workflow started..."
}
```
