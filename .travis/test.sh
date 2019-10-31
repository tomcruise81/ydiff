#!/bin/bash

# if [ "$TRAVIS_OS_NAME" = 'windows' ]; then
    # Re-activate the virtualenv
    # source "envs/python${PYTHON_VERSION}/Scripts/activate"
# fi

make test
