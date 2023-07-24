# azure-shutter-pages

This repo contains shutter pages for when a site is unavailable

Pattern information on this is available here:
https://design-system.service.gov.uk/patterns/service-unavailable-pages/

## How do I create a new shutter page?

1. Create a folder in the root directory if your application requires a custom page. You should ensure that folder name matches [name](https://github.com/hmcts/azure-platform-terraform/blob/7e7b76e6477b746be5d61a1eaf0b512884ecb56d/environments/prod/prod.tfvars#L564) key. Copy static contents inside the folder. 
2. To properly set up the workflow for your application, you need to copy the [pipeline_template.yaml](./pipeline_template.yaml) file from the repository root and paste it into the .github/workflows/ folder. Once it's there, make sure to rename the file to match the name of your application. `eg. plum.yaml`
3. In the file, replace `<app_name>` with the `name` of the folder that was created in the previous step. Alternatively, you can use the word `default` if you prefer to have a default shutter page. Replace `<env>` with the environment[sbox or prod] name.
4. Submit the PR for review.

The easiest way to check rendering is with:

```shell
cd default/
python3 -m http.server
open http://localhost:8000
```

If you are migrating from the legacy shuttering solution, update the list of apps in [cnp-shutter-application](https://github.com/hmcts/cnp-shutter-application/blob/master/Jenkinsfile#L8).

