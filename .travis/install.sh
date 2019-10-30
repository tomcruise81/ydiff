#!/bin/bash

if [ "$TRAVIS_OS_NAME" = 'windows' ]; then
    # Install some custom requirements on Windows
    choco install python --version="${PYTHON_VERSION}" | tee pythonInstallerOutput.txt
    pythonInstallationPath=`cat pythonInstallerOutput.txt | grep 'Installed to: ' | awk '{ print $3 }' | sed -E -e 's|\\\\|/|g' -e "s/^'//" -e "s/'$//"`
    echo "Python installed to: ${pythonInstallationPath}"
    rm pythonInstallerOutput.txt
    # Use an explicit version since choco install doesn't seem to be sufficient
    PYTHON="${pythonInstallationPath}/python"
    # This doesn't seem to be sufficient either
    # export PATH="${pythonInstallationPath}:${PATH}"
    # PYTHON="python"

    choco install make

    mkdir bin
    curl https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/cscope-win32/patchutils-0.3.1.win32rev2-bin.7z -o bin/patchutils.7z
    7z e bin/patchutils.7z -obin
    chmod +x ./bin/filterdiff.exe
    export PATH="./bin:${PATH}"

    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    ${PYTHON} get-pip.py
    rm -f get-pip.py

    ${PYTHON} -m pip install --target=ve virtualenv
    ${PYTHON} "ve/virtualenv.py" "ve/python${PYTHON_VERSION}"
    source "ve/python${PYTHON_VERSION}/Scripts/activate"
fi

pip install -r requirements.txt
coverage --version

if [ "$TRAVIS_OS_NAME" = 'linux' ]; then
    # Update components on Linux
    sudo apt-get update
    sudo apt-get --quiet=2 install patchutils
fi

python setup.py --quiet install
