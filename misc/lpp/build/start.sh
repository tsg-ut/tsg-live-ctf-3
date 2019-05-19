#!/bin/sh

timeout 60 stdbuf -i0 -o0 -e0 /ocaml/runtime/ocamlrun /ocaml/ocaml -nostdlib -nopervasives
