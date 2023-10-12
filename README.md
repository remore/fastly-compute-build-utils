# fastly-compute-build-utils

Supplemental materials for setting up build environment for Fastly Compute. Please visit [developer hub](https://developer.fastly.com/learning/compute/#getting-started) for official getting started guide if you haven't, which let you install depenencies natively on your system. Complementary this repository will show you a few alternative ways to build and deploy WASM packages using your favorite language with Fastly Compute;

- a. Build with container (Dockerfile)
- b. Build and deploy without anything installed on your system

## a. Build with container (Dockerfile)

All you need to have to proceed with this path is a [valid API token](https://developer.fastly.com/reference/api/auth-tokens/user/) associated with your Fastly account, and a docker environment installed onto your system.

Please go visit one of folders with language of your choice and follow the instruction there to start building your package.

- [Rust](./Rust/)
- [Go](./Go/)
- [JavaScript](./JavaScript/)

## b. Build and deploy without anything installed on your system

This is rather an extreme way of building and deploying your WASM package to Fastly's production fleet - but it's doable. Keep it mind that this approach is recommended only for evaluation and temporary purpose (e.g. workshop, hackathon etc).

A fastly account is the only prerequisite. Please make sure you have a [valid API token](https://developer.fastly.com/reference/api/auth-tokens/user/) before proceeding with steps below.

1. Visit [fiddle](https://fiddle.fastly.dev/) and write your code at to build a WASM binary
2. Once it's succesfully built, grab your FIDDLE_ID from the fiddle url (e.g. use `3a6c16f5` if the url is https://fiddle.fastly.dev/fiddle/3a6c16f5) and run the following command (Make sure you replace FIDDLE_ID with your own one!) [1]
```
(export FIDDLE_ID=3a6c16f5; export PACKAGE_NAME=$FIDDLE_ID-v$(curl -s https://fiddle.fastly.dev/fiddle/$FIDDLE_ID -H 'Accept:application/json;' | jq .fiddle.srcVersion); export FIDDLE_TMP_DIR=$(mktemp -d); export PACKAGE_TMP_DIR=$(mktemp -d); curl -sLO "https://storage.googleapis.com/fiddle-compute-cache/fiddles/$FIDDLE_ID/$PACKAGE_NAME.tar"; tar -xzf $PACKAGE_NAME.tar -C $FIDDLE_TMP_DIR; mv $PACKAGE_NAME.tar $PACKAGE_TMP_DIR; cd $FIDDLE_TMP_DIR; mkdir bin; mv main.wasm ./bin; tar -zcvf $PACKAGE_TMP_DIR/package-$PACKAGE_NAME.tar.gz ./ > /dev/null 2>&1; mv $PACKAGE_TMP_DIR/package-$PACKAGE_NAME.tar.gz ./; echo "Your package file is ready at:\n  $FIDDLE_TMP_DIR";)
```

3. If the command above was successful you will get a temporary folder path, where you can pick a package file named like `package-3a6c16f5-v59.tar.gz`. Below is an example output of this;

```bash
$ (export FIDDLE_ID=3a6c16f5; export PACKAGE_NAME=$FIDDLE_ID-v$(curl -s https://fiddle.fastly.dev/fiddle/$FIDDLE_ID -H 'Accept:application/json;' | jq .fiddle.srcVersion); export FIDDLE_TMP_DIR=$(mktemp -d); export PACKAGE_TMP_DIR=$(mktemp -d); curl -sLO "https://storage.googleapis.com/fiddle-compute-cache/fiddles/$FIDDLE_ID/$PACKAGE_NAME.tar"; tar -xzf $PACKAGE_NAME.tar -C $FIDDLE_TMP_DIR; mv $PACKAGE_NAME.tar $PACKAGE_TMP_DIR; cd $FIDDLE_TMP_DIR; mkdir bin; mv main.wasm ./bin; tar -zcvf $PACKAGE_TMP_DIR/package-$PACKAGE_NAME.tar.gz ./ > /dev/null 2>&1; mv $PACKAGE_TMP_DIR/package-$PACKAGE_NAME.tar.gz ./; echo "Your package file is ready at:\n  $FIDDLE_TMP_DIR";)
Your package file is ready at:
  /var/folders/5h/v8pfwm2136l9_q3m7pbzkq_w0000gp/T/tmp.VleR9APR
$ ls -al /var/folders/5h/v8pfwm2136l9_q3m7pbzkq_w0000gp/T/tmp.VleR9APR
total 2128
drwx------    5 kaysawada  staff      160 Oct 12 15:32 .
drwx------@ 360 kaysawada  staff    11520 Oct 12 15:32 ..
drwxr-xr-x    3 kaysawada  staff       96 Oct 12 15:32 bin
-rwxr-xr-x    1 kaysawada  staff      364 Jan  1  1970 fastly.toml
-rw-r--r--    1 kaysawada  staff  1084976 Oct 12 15:32 package-3a6c16f5-v59.tar.gz
```

In this example, `package-3a6c16f5-v59.tar.gz` can be uploaded via either Fastly App (Admin console of Web UI) or Fastly CLI (using `$fastly compute deploy` command).

[1] If you don't have `jq` command available on your system, you can always manually generate PACKAGE_NAME env variable by the command below and use it in the aforementioned command(Make sure you use your own fiddle url for curl command);
```
(export FIDDLE_ID=3a6c16f5; echo $FIDDLE_ID-v$(curl -s https://fiddle.fastly.dev/fiddle/$FIDDLE_ID -H 'Accept:application/json;' | awk '{print substr($0, index($0, "srcVersion"))}' | awk '{sub(",.*", "");print substr($0, index($0, ":"));}' | cut -c 2-))
```

## License
MIT