#!/usr/bin/env sh
export CPP_FLAGS="-D_WASI_EMULATED_SIGNAL -D_WASI_EMULATED_PROCESS_CLOCKS -D_WASI_EMULATED_GETPID -Dgetpid=getpagesize -Dgetuid=getpagesize -Dgeteuid=getpagesize -Dgetgid=getpagesize -Dgetegid=getpagesize"
export LD_FLAGS="-lwasi-emulated-signal -lwasi-emulated-process-clocks -lwasi-emulated-getpid"
exec /usr/bin/clang --target=wasm32-wasi --sysroot /wasi-libc "$CPP_FLAGS" "$LD_FLAGS" "$@"
