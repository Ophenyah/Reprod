FROM ocaml/opam:debian-11-ocaml-5.4

WORKDIR /app
COPY --chown=opam:opam . .
RUN opam install . --deps-only  -y
RUN opam exec -- dune build
RUN chmod -R a+rwX /app
CMD ["./run.sh"]