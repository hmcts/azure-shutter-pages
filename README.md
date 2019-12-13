# azure-shutter-pages

This repo contains shutter pages for when a site is unavailable

Pattern information on this is available here:
https://design-system.service.gov.uk/patterns/service-unavailable-pages/

There is a default shutter page for legacy apps and ones that haven't had time / a need to create an app specific one.

Otherwise it's expected that you have a planned and unplanned maintenance folder.

All content can be updated via a pull request

The easiest way to check rendering is with:

```shell
cd default/
python3 -m http.server
open http://localhost:8000
```

