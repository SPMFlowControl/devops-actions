# GitHub Action to run the Weir CI Node tool

This GitHub Action utilizes the internal-only [weir-ci-node](https://developers.weir/docs/guides/node/weir-ci-node-guide.html) tool.

## Configuration

### Secrets

|Secret|Example|Description|Optional|
|---|---|---|---|
|`OAUTH_TOKEN`|`mytoken`|This is a [personal access token](https://github.com/settings/tokens) from GitHub.|❌|
|`PROJECT_PATH`|`./`|Relative path to your project root. Defaults to `./`|✅|
|`REPORTS_PATH`|`./results/`|Relative path to store results. Defaults to `./results/`|✅|

### Secrets/Run Options

If any of the options below are not included then the respective option will not be used to run weir-ci-node.

|Secret|Example|Description|Optional|
|---|---|---|---|
|`SLACK_TOKEN`|`xoxb-xxxxxxxxx-xxxx`|Valid Slack token for your workspace.|✅|
|`SLACK_CHANNEL`|`#devops`|Valid Slack channel for your workspace.|✅|
|`ZAP_TARGET_URL`|`http://localhost/`|URL to perform the [Zed Attack Proxy](https://developers.weir/docs/guides/zap-guide.html) `active-scan` on.|✅|
|`RETIRE`|`true`|Use [Retire.js](https://retirejs.github.io/retire.js/) to scan for component vulnerabilities.|✅|
|`JEST`|`true`|Run [Jest](https://jestjs.io/) unit tests on a standard project.|✅|
|`JESTCRA`|`true`|Run [Jest](https://jestjs.io/) unit tests on a create-react-app project. Do not use `JEST` while using this option!|✅|
|`CYPRESS_KEY`|`XXXXXXXXX`|Run [Cypress](https://cypress.io) E2E tests on the project.|✅|

### Environment variables

|Variable|Example|Description|Optional|
|---|---|---|---|
|`NPM_RUN_CMD`|`start`|The npm run `command` to use to start the project.|❌|

### Project Environment Variables

Since the Weir CI Node tool launches your project internally, the GitHub Action also requires that you provide any other project dependant environment variables used to run your application.

### Workflow

```javascript
workflow "New Commit" {
  on = "push"
  resolves = ["Run Weir-CI-Node"]
}

action "Run Weir-CI-Node" {
  uses = "weirgroup/devops-actions/weir-ci-node@master"
  secrets = ["OAUTH_TOKEN", "PROJECT_PATH", "REPORTS_PATH", "RETIRE", "SLACK_CHANNEL", "SLACK_TOKEN" "ZAP_TARGET_URL"]
  env = {
    NPM_RUN_CMD = "start"
  }
}
```
