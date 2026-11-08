#!/bin/bash


run() {
  local out
  if out=$("$@" 2>/tmp/err.txt </dev/null); then
    echo "$out" | tail -n1
  else
    echo "FAILED: $*" >&2
    cat /tmp/err.txt >&2
    echo ERROR
  fi
}


cd "$(dirname "$0")"


touch output.csv

echo "config_id,origin_of_config,Language,Ocaml,ENV,Typed,Distribution,Range,Iterations, result" > output.csv

while IFS=, read -r field1 field2 lang env dock type gen range iter
do
    res=-1

    iter=${iter//[$'\r" \t']/}
    clean_iter=-1
    range=${range//[$'\r" \t']/}
    clean_interval=-1
    lang=${lang//[$'\r" \t']/}
    type=${type//[$'\r" \t']/}
    clean_type=""

    env=${env//[$'\r" \t']/}


    if [ "$iter" = "100" ]; then
        clean_iter=0
    elif [ "$iter" = "1000" ]; then
        clean_iter=1
    elif [ "$iter" = "1000000" ]; then
        clean_iter=2
    fi


    if [ "$range" = "[0!1]" ]; then
        clean_interval=0
    elif [ "$range" = "[-1e16!1e16]" ]; then
        clean_interval=1
    elif [ "$range" = "[-1e10!1e10]" ]; then
        clean_interval=2
    fi

    if [[ ! $dock = "Docker" ]]; then
        if [ $lang  = "Python" ]; then
            
            clean_type=P
            if [ "$type" = "Float" ]; then
                clean_type=0
            elif [ "$type" = "Decimal" ]; then
                clean_type=1
            fi
             res=$(run python3 ./python/assoc.py -iter $clean_iter -range $clean_interval -type $clean_type)
        elif [ $lang = "Ocaml" ]; then
            
            if [ "$type" = "Float" ]; then
                clean_type=""
            elif [ "$type" = "Z" ]; then
                clean_type="-Z"
            fi

            if [ "$env" = "ocamlopt" ]; then
            ocamlfind ocamlopt -package zarith -linkpkg ./ocaml/bin/main.ml -o $field1
             res=$(run ./$field1 -iter $clean_iter -range $clean_interval  $clean_type)
            else
             res=$(run dune exec  --no-print-directory --root ./ocaml assoc -- -iter $clean_iter -range $clean_interval  $clean_type)
            fi
        fi
    else
            if [ $lang  = "Python" ]; then
            type=${type//[$'\r" \t']/}
            
            clean_type=P
            if [ "$type" = "Float" ]; then
                clean_type=0
            elif [ "$type" = "Decimal" ]; then
                clean_type=1
            fi
            res=$(run docker run --rm python_samp -iter $clean_iter -range $clean_interval -type $clean_type)
        elif [ $lang = "Ocaml" ]; then
            
            clean_type=""
            if [ "$type" = "Float" ]; then
                clean_type=""
            elif [ "$type" = "Z" ]; then
                clean_type="-Z"
            fi
             res=$(run docker run --rm ocaml_samp -- -iter $clean_iter -range $clean_interval  $clean_type)
        fi
    fi

echo "$field1,$field2,$lang,$env,$dock,$type,$gen,$range,$iter,$res" >> output.csv
done < <(tail -n +2 "../Part 5/configs/sample.csv" | tr -d '\r')