#!/bin/sh

package_name=$(toml get -r Cargo.toml package.name)

if [ "$(uname)" == "Darwin" ]; then
    compiled_name="lib${package_name}.dylib"
    expected_name="${package_name}.so"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    compiled_name="lib${package_name}.so"
    expected_name="${package_name}.so"
else
    compiled_name="${package_name}.dll"
    expected_name="${package_name}.dll"
fi


[ -d lua ] || mkdir lua
cargo build --release

mv "target/release/${compiled_name}" "lua/${expected_name}"
