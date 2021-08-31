# How to publish a new version
## Manual steps
1. Tag code using 0.1.0 (without `v`)
2. Change the tagged version in the spec file
3. run command `pod trunk push {FrameworkSpecsFile}`

## Auto script
1. `cd` to the project root folder
2. run command `sh Scripts/release {version} {releaseMessage}`
