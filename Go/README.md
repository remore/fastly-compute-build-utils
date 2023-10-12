## How to use
```bash
docker build -t fastly-compute-go . && docker run -it -v ./:/app fastly-compute-go /bin/bash
root@a3c6d940901d:/app# git clone https://github.com/fastly/compute-starter-kit-go-default.git src
root@a3c6d940901d:/app# cd src
root@a3c6d940901d:/app# fastly compute build
root@a3c6d940901d:/app# fastly compute publish --token=<INSERT-YOUR-APIKEY>
```

## Pro Tips for debugging

### How to show service version
This will help you identify which version of services is running on production fleet.
```go
fmt.Println("FASTLY_SERVICE_VERSION:", os.Getenv("FASTLY_SERVICE_VERSION"))
```

## How to add package
Use `go get` (or `go install` and `go mod tidy`) to add a new dependency to your package.

## How to embed a file into WASM package
[embed](https://pkg.go.dev/embed)(Go's standard library) is helpful for this.
```go
// go:embed test.txt
var SAMPLE_TEXT_DATA string
```