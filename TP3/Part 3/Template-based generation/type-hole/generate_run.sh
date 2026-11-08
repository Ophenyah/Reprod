#!/usr/bin/env bash

python3 ./generate.py

mkdir -p ./build

for f in ./generated/*.ml; do
    name=$(basename "$f" .ml)
    echo $f
    ocamlfind ocamlopt -package zarith -linkpkg $f -o "./build/$name"
    ./build/$name
done

rm -r ./build
rm ./generated/*.cmi
rm  ./generated/*.cmx
rm  ./generated/*.o