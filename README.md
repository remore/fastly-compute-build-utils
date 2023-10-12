# fastly-compute-build-utils

Supplemental materials for setting up build environment for Fastly Compute. Please visit [developer hub](https://developer.fastly.com/learning/compute/#getting-started) for official getting started guide if you haven't, which let you install depenencies natively on your system. Complementary this repository will show you a few alternative ways to build and deploy WASM packages like below using your favorite language with Fastly Compute;

- a. Build with container (Dockerfile)
- b. Build and deploy without nothing installed onto your system

## a. Build with container (Dockerfile)

All you need to have to proceed with this path is a [valid API token](https://developer.fastly.com/reference/api/auth-tokens/user/) associated with your Fastly account, and a docker environment installed onto your system.

Please go visit one of folders with language of your choice and follow the instruction there.

- [Rust](./Rust/)
- [Go](./Go/)
- [JavaScript](./JavaScript/)

## b. Build and deploy without installing anything

This is rather an extreme way of building and deploying your WASM package to Fastly's production fleet - but it's doable. Keep it mind that this approach is recommended only for evaluation and temporary purpose (e.g. workshop, hackathon etc).

A fastly account is the only prerequisite in this case. Please make sure you have a [valid API token](https://developer.fastly.com/reference/api/auth-tokens/user/) before proceeding with steps below.

1. Visit [fiddle](https://fiddle.fastly.dev/) and write your code at to build a WASM binary
2. Once it's succesfully built, grab your FIDDLE_ID from the fiddle url (e.g. use `3a6c16f5` if the url is https://fiddle.fastly.dev/fiddle/3a6c16f5) and run the following command (Make sure you replace FIDDLE_ID with your own one!) [1]
```
(export FIDDLE_ID=3a6c16f5; export PACKAGE_NAME=$FIDDLE_ID-v$(curl -s https://fiddle.fastly.dev/fiddle/$FIDDLE_ID -H 'Accept:application/json;' | jq .fiddle.srcVersion); export FIDDLE_TMP_DIR=$(mktemp -d); export PACKAGE_TMP_DIR=$(mktemp -d); curl -sLO "https://storage.googleapis.com/fiddle-compute-cache/fiddles/$FIDDLE_ID/$PACKAGE_NAME.tar"; tar -xzf $PACKAGE_NAME.tar -C $FIDDLE_TMP_DIR; mv $PACKAGE_NAME.tar $PACKAGE_TMP_DIR; cd $FIDDLE_TMP_DIR; mkdir bin; mv main.wasm ./bin; tar -zcvf $PACKAGE_TMP_DIR/package-$PACKAGE_NAME.tar.gz ./ > /dev/null 2>&1; mv $PACKAGE_TMP_DIR/package-$PACKAGE_NAME.tar.gz ./; echo "Your package file is ready at:\n  $FIDDLE_TMP_DIR";)
```

3. If the command was successful you will get a temporary folder path like `/var/folders/5h/v8pfwm2136l9_q3m7pbzkq_w0000gp/T/tmp.Tz2JOYq7`. You can pick a package file named like `package-3a6c16f5-v59.tar.gz`. This file can be uploaded via either Fastly App (Admin console of Web UI) or Fastly CLI (using `$fastly compute deploy` command).

[1] If you don't have `jq` command installed with your system, you can always manually check FIDDLE_SRC_VERSION value by the command below (Make sure you use your own fiddle url for curl command);
```
curl -s https://fiddle.fastly.dev/fiddle/3a6c16f5 -H 'Accept:application/json;' | awk '{print substr($0, index($0, "srcVersion"))}' | awk '{sub(",.*", "");print substr($0, index($0, ":"));}' | cut -c 2-
```

## License
MIT