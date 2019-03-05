# GitHub Action to run OWASP testing against dotnet core Web API

This Action is for perform OWASP testing against a given dotnet core web API project.

## Configuration

### Secrets

|Secret|Example|Description|Optional|
|---|---|---|---|
|`PROJECT_PATH`|`./src/WEIR.CDE.OG.ServiceAPP.API/WEIR.CDE.OG.ServiceAPP.API.csproj`|Relative path to your project file.|❌|


### Project Environment Variables

Since this action launches your project internally, the GitHub Action also requires that you provide any other project dependant environment variables used to run your application.

### Workflow

```javascript
workflow "New Commit" {
  on = "push"
  resolves = ["Run OWASP Test"]
}

action "Run OWASP Test" {
  uses = "weirgroup/devops-actions/weir-owasp-dotnetcore@dotnetcore-api-owasp-testaction"
  secrets = ["PROJECT_PATH"]
  env = {    
  }
}
```
