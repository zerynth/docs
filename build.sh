#!/bin/sh

DOCPATH=$1

if [ -z "$DOCPATH" ]; then
    DOCPATH=${PWD}
fi

docker run --rm -t -v $DOCPATH:/docs squidfunk/mkdocs-material:5.1.6 build
