
## How to use
```bash
docker build -t fastly-compute-rust . && docker run -it -v ./:/app fastly-compute-rust /bin/bash
root@a3c6d940901d:/app# git clone https://github.com/fastly/compute-starter-kit-rust-default.git src
root@a3c6d940901d:/app# cd src
root@a3c6d940901d:/app# fastly compute build
root@a3c6d940901d:/app# fastly compute publish --token=<INSERT-YOUR-APIKEY>
```

## Pro Tips for debugging

### How to show service version
This will help you identify which version of services is running on production fleet.
```rust
    println!(
        "FASTLY_SERVICE_VERSION: {}",
        std::env::var("FASTLY_SERVICE_VERSION").unwrap_or_else(|_| String::new())
    );
```

### How to add package
Use `cargo add` command to add a new dependency to your package.

### How to embed a file into WASM package
`include_bytes!` or `include_str!` macros are helpful for this.
```rust
#[fastly::main]
fn main(_req: Request) -> Result<Response, Error> {
    let bytes = include_bytes!("test.txt");
    print!("{}", String::from_utf8_lossy(bytes));
    Ok(Response::from_status(StatusCode::OK))
}
```