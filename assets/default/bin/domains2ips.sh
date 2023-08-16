#! /bin/sh

grep -v '^#' "$@" | \
    xargs -n1 nslookup | \
    awk '/Address: +/ {print $2;}' | \
    sort | \
    uniq
