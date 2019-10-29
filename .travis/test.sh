#!/bin/bash

if [ "$TRAVIS_OS_NAME" = 'windows' ]; then
    # Re-activate the virtualenv
    source "ve/python${PYTHON_VERSION}/Scripts/activate"
    export PATH="./bin:${PATH}"
fi

make test
