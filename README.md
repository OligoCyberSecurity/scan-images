# Scan Docker Images

[![Tests Passing](https://github.com/spicyparrot/scan-images/actions/workflows/create_tag.yml/badge.svg)](https://github.com/spicyparrot/scan-images/actions/workflows/create_tag.yml)

This is a composite action that uses the the excellent [Trivy](https://aquasecurity.github.io/trivy) by Aqua Security to scan in-memory docker images for security issues.

This can be used to flag security issues prior to pushing to an image registry, such as Docker Hub, to further improve a shift left development life cycle.

## Key Features

- Scans any in-memory image and not just public images
- Allows scanning prior to pushing
- Scan multiple images in a single task
- Generates a single report with the results of all images scanned
- Parses out the total issues found to allow for error thresholding

## Current Limitations

- Only scanning for vulnerabilities currently `--security-checks vuln` this will be expanded out optional to all security checks in the future (vuln,config,secret,license)

## Requirements

- Images to be scanned available in memory prior to scanning

## Example workflow

```yaml
name: 🧪 Test
on: 
  workflow_dispatch:
    
jobs:
  test:
    name: ☢ Test Scan
    runs-on: ubuntu-latest
    steps:
      - name: 🛀 Checkout Self
        uses: actions/checkout@v3
      
      - name: ⏬ Load Test Images
        run: |
          docker pull python:3.4-alpine
          docker pull python:3.8.10-slim
          docker pull node:19-alpine # Will be ignored via `image_exclude_grep`

      - name: ☢ Scan Images
        uses: spicyparrot/scan-images@trunk
        id: python
        with:
          image_grep: "python"
          image_exclude_grep: "node"
          severities: "CRITICAL,HIGH"   
```

### Inputs

| Input  |  Required | Values  | Default | Description  | 
|---|---|---|---|---|
| `image_grep`  | true  | String  |   | String used to grep for all matching images to be scanned e.g. "python"
| `image_exclude_grep`  | false  | String  |   | String used to ignore images e.g. "node"
| `severities` | false  | Comma separated list  | 'HIGH,CRITICAL' | List of severities to scan for
| `upload_reports` | false  | true or false | true  | Option to be able to download html reports
| `exit_on_error` | false  | true or false  | true | Return an error if any issues are found

### Outputs

| Output                                             | Description                                        |
|------------------------------------------------------|-----------------------------------------------|
| `issues`  | The total number of issues found    |


### GitHub Action Decorations

![Actions Summary](docs/screenshots/actions_outputs.jpg)
