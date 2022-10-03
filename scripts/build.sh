#!/bin/bash

# Safely execute this bash script
# e exit on first failure
# x all executed commands are printed to the terminal
# u unset variables are errors
# a export all variables to the environment
# E any trap on ERR is inherited by shell functions
# -o pipefail | produces a failure code if any stage fails
set -Eeuoxa pipefail

# Get the directory of this script
LOCAL_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Get the platform name
PLATFORM=$($LOCAL_DIRECTORY/get_platform_name.sh)

if [ "$PLATFORM" = "rocm" ]
then
    BASE_NAME="rocm/tensorflow"
else
    BASE_NAME="python:3.9"
fi

echo "Building for '$PLATFORM' using base container '$BASE_NAME'"

docker build -t landing-ai:latest --build-arg BASE_NAME=$BASE_NAME $LOCAL_DIRECTORY/..

