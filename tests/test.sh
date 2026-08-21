#!/bin/bash

set -e

SCRIPT=$1

if [ ! -f "$SCRIPT" ]; then
    echo "Error: $SCRIPT not found."
    exit 1
fi

bash -n "$SCRIPT"

echo "Syntax is correct."
