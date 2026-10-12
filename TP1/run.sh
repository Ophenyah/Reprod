#!/usr/bin/env bash
set -e
dune exec -- assoc -seed 48596 -type a -nb 100000000 > /out/answer_associativity.txt
dune exec -- assoc -type bn > /out/answer_banking.txt
