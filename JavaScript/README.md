
## How to use
```bash
docker build -t fastly-compute-javascript . && docker run -it -v ./:/app fastly-compute-javascript /bin/bash
root@a3c6d940901d:/app# git clone https://github.com/fastly/compute-starter-kit-javascript-default.git src
root@a3c6d940901d:/app# cd src
root@a3c6d940901d:/app# npm install # Do not miss this step
root@a3c6d940901d:/app# fastly compute build
root@a3c6d940901d:/app# fastly compute publish --token=<INSERT-YOUR-APIKEY>
```

## Pro Tips for debugging

### How to show service version
This will help you identify which version of services is running on production fleet.
```javascript
  console.log("FASTLY_SERVICE_VERSION:", env('FASTLY_SERVICE_VERSION') || 'local');
```

## How to add package
Use whichever package manger makes best sense to you(e.g. `npm install` for npm).

## How to embed a file into WASM package
[JSON module](https://github.com/tc39/proposal-json-modules) is one way to do this. 