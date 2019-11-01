#!/bin/bash

if [ "$TRAVIS_OS_NAME" = 'windows' ]; then
    # Re-activate the virtualenv
    source "envs/python${PYTHON_VERSION}/Scripts/activate"

    # Ensure that PATH includes our temp bin directory
    export PATH="$(pwd)/bin:${PATH}"
fi

if [[ "${PYTHON_VERSION}" == 3* ]]; then
    PYTHON=python3 make test3
else
    make test
fi
