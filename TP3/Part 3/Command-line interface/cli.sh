#!/usr/bin/env bash

TP1_DIR=../../../TP1
TP2_DIR=../../../TP2LLM
TP3_DIR=../../../TP3/LLM_Assoc

for r in 100 1000 10000; do
  echo r = $r
  (cd "$TP1_DIR" && dune exec -- assoc -seed 48596 -type a -nb $r -pp)
  (cd "$TP2_DIR" && python3 ./llm.py  associativity -pp -nb $r)
  (cd "$TP3_DIR" && dune exec -- LLM_Assoc -nb $r -pp)
done