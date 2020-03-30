# azure-shutter-pages

This repo contains shutter pages for when a site is unavailable

Pattern information on this is available here:
https://design-system.service.gov.uk/patterns/service-unavailable-pages/

## How do I create a new shutter page?

Follow the instructions in the main documentation repository: https://hmcts.github.io/ways-of-working/path-to-live/shutter.html#uploading-static-shutter-pages-to-azure-storage-account

The easiest way to check rendering is with:

```shell
cd default/
python3 -m http.server
open http://localhost:8000
```

If you are migrating from the legacy shuttering solution, update the list of apps in [cnp-shutter-application](https://github.com/hmcts/cnp-shutter-application/blob/master/Jenkinsfile#L8).