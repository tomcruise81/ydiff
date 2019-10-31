#!/bin/bash

if [ "$TRAVIS_OS_NAME" = 'windows' ]; then
    # Re-activate the virtualenv
    source "envs/python${PYTHON_VERSION}/Scripts/activate"

    # Ensure that PATH includes our temp bin directory
    export PATH="$(pwd)/bin:${PATH}"
fi

make test
