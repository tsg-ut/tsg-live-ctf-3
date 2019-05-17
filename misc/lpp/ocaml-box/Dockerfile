FROM ubuntu:18.04

RUN apt-get update && \
        apt-get -y upgrade

RUN apt-get install -y \
            git \
            build-essential \
            ocaml-nox

WORKDIR /

ENV COMMIT_ID a940f7c3714d1b20c1f730d0dfde0e3727079919
RUN mkdir ocaml && \
    cd ocaml && \
    git init && \
    git remote add origin https://github.com/ocaml/ocaml && \
    git fetch --depth 1 origin $COMMIT_ID && \
    git checkout $COMMIT_ID

WORKDIR /ocaml

RUN ./configure && make world.opt

CMD make runtop
