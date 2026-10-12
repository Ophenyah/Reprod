#!/usr/bin/env bash
set -e
dune exec -- assoc -seed 48596 -type a -nb 100000000 > answer_associativity.txt
dune exec -- assoc -type bn > answer_banking.txt
