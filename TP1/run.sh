#!/usr/bin/env bash
set -e
dune exec -- assoc -seed 48596 -type d -nb 100000000 > /out/answer_distributivity.txt
