# Custom Docker Build Image with Helpers

Esta es una imagen de buildeo de dockerfiles con el "docker-credential-gcr" para el push a las registry de GCloud

```bash
{
  "auths": {},
  "credHelpers": {
    "gcr.io": "gcr",
    "us.gcr.io": "gcr",
    "eu.gcr.io": "gcr",
    "asia.gcr.io": "gcr",
    "marketplace.gcr.io": "gcr"
  }
}
```