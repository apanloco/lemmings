#!/usr/bin/env bash
rm -rf build
rustup target add wasm32-unknown-unknown
cargo build --target wasm32-unknown-unknown --release
cargo install -f wasm-bindgen-cli --version 0.2.91
wasm-bindgen --out-dir build --target web ./target/wasm32-unknown-unknown/release/lemmings.wasm
cp web/* build/
cp -r assets build/
