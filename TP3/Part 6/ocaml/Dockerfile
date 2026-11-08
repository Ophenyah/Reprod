FROM ocaml/opam:debian-12-ocaml-5.4

WORKDIR /app
COPY --chown=opam:opam . .
RUN opam install . --deps-only  -y
RUN opam install zarith -y
RUN opam exec -- dune build
RUN chmod -R a+rwX /app
ENTRYPOINT ["opam", "exec", "--", "dune", "exec", "--no-build", "assoc"]