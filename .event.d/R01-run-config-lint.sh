#!/bin/bash

DOCKERIMAGE_NAME=stelligent/config-lint
PROJECT_FOLDER=""
IMAGE_REBUILD=

# Execute only on GIT pre-commit
if ! [ "$GIT_HOOK_EVENT" = "pre-commit" ]; then exit 0; fi

# Redirect output to stderr.
exec 1>&2

if [ $(uname -o ) == "Msys" ] || [ $(uname -o ) == "Cygwin" ]; then
	# Windows MINGW or Cygwin Compatible Bash
	PROJECT_FOLDER=$(pwd -W)
else
	PROJECT_FOLDER=$(pwd)
fi

docker run --env-file .env -v $PROJECT_FOLDER:/foobar $DOCKERIMAGE_NAME

exit 0; #TODO: Create Rules in config-lint and remove this!