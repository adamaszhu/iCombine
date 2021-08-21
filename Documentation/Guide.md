# How to publish a new version
1. Tag code using 0.1.0 (without `v`)
2. Change the tagged version in the spec file
3. run command `pod repo push {FrameworkSpecs} {FrameworkSpecsFile}`

# Add the customized spec to your pod env for the first time
`pod repo add {FrameworkSpecs} {FrameworkSpecsRepoURL}`
