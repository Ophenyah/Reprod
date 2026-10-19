#!/usr/bin/env bash
set -e
python3 ./llm.py  associativity > /out/answer_associativity_llm.txt
python3 ./llm.py  bank > /out/answer_banking_llm.txt
