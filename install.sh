#!/usr/bin/env bash
if [[ $# != 1 ]]; then
    echo "Usage: $0 <uri>"
    exit 1
fi

DEFAULT_URI=$1
waveship . ${URI:-$DEFAULT_URI}
