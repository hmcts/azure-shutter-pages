# azure-shutter-pages

This repo contains shutter pages for when a site is unavailable

Pattern information on this is available here:
https://design-system.service.gov.uk/patterns/service-unavailable-pages/

## What's provided

There is a default shutter page for legacy apps and ones that haven't had time / a need to create an app specific one.

Otherwise it's expected that you have a planned and unplanned maintenance folder.

## How do I create a new shutter page?

1. Follow the instructions in [azure-platform-terraform](https://github.com/hmcts/azure-platform-terraform/tree/master/components/shutter)
that will create your storage accounts and the configuration required for shuttering.

2. Create directories for your shutter page(s), `mkdir probateplanned probateunplanned`

3. Copy the default shutter page, `cp -R default/* probateplanned/`

4. Edit the content in `index.html`

5. Preview it locally, see [instructions](#how-to-update).

6. Update the CODEOWNERS file with your teams folders and GitHub team

7. Create a pull request to this repo, and ask in #cloud-native for review (after the first merge your team can review)

8. Update the list of apps in [cnp-shutter-application](https://github.com/hmcts/cnp-shutter-application/blob/master/Jenkinsfile#L8)


## How to update
All content can be updated via a pull request

The easiest way to check rendering is with:

```shell
cd default/
python3 -m http.server
open http://localhost:8000
```

