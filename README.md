# azure-shutter-pages

This repo contains shutter pages for when a site is unavailable

Pattern information on this is available here:
https://design-system.service.gov.uk/patterns/service-unavailable-pages/

## Default Shutter page - Schedule Job

This repository includes a scheduled GitHub Action (.github/workflows/default.yaml) that runs every hour. The action checks for any static apps that do not have pages uploaded for the specified subscriptions and resource groups. So if you do not require `custom` page for your application, you would not need to do anything on this repository.  Please note that the schedule job only process one App at time so if there are multiple static apps without default pages, it may take couple of hours to see default pages uploaded.

```shell
   a8140a9e-f1b0-481f-a4de-09e2ee23f7ab: sds-platform-shutter-webapp-sbox-rg  
   b72ab7b7-723f-4b18-b6f6-03b0f2c6a1bb: cft-platform-shutter-webapp-sbox-rg  
   5ca62022-6aa2-4cee-aaa7-e7536c8d566c: sds-platform-shutter-webapp-prod-rg  
   8cbc6f36-7c56-4963-9d36-739db5d00b27: cft-platform-shutter-webapp-prod-rg  
   ed302caf-ec27-4c64-a05e-85731c3ce90e: MTA-STS-Site  
```

## How do I create a new shutter page?

1. Create a folder in the root directory if your application requires a custom page. You should ensure that folder name matches [name](https://github.com/hmcts/azure-platform-terraform/blob/7e7b76e6477b746be5d61a1eaf0b512884ecb56d/environments/prod/prod.tfvars#L564) key. Copy static contents inside the folder. 
2. To properly set up the workflow for your application, you need to copy the [pipeline_template.yaml](./pipeline_template.yaml) file from the repository root and paste it into the .github/workflows/ folder. Once it's there, make sure to rename the file to match the `name` of your application. `eg. plum.yaml`
3. In the file, 
   1. Replace `<app_name>` with the `name` of the folder that was created in the previous step. Alternatively, you can use the word `default` if you prefer to have a default shutter page.
   2. Replace `<file_name>` with the `name` of the workflow file that was created in the previous step.
   3. Replace `<env>` with the environment[sbox or prod] name. 
   4. Swap `-` with a `_` in the `name` of the folder before replace `<app_name_secret>`.  
4. Submit the PR for review.

The easiest way to check rendering is with:

```shell
cd default/
python3 -m http.server
open http://localhost:8000
```

If you are migrating from the legacy shuttering solution, update the list of apps in [cnp-shutter-application](https://github.com/hmcts/cnp-shutter-application/blob/master/Jenkinsfile#L8).

