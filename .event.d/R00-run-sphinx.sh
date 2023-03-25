#!/bin/bash

DOCKERIMAGE_NAME=publish-confluence
PROJECT_FOLDER=""

# Execute only on GIT pre-push
if ! [ "$GIT_HOOK_EVENT" = "pre-push" ]; then exit 0; fi

# Redirect output to stderr.
exec 1>&2

if [ $(uname -o ) == "Msys" ] || [ $(uname -o ) == "Cygwin" ]; then
	# Windows MINGW or Cygwin Compatible Bash
	PROJECT_FOLDER=$(pwd -W)
else
	PROJECT_FOLDER=$(pwd)
fi

#docker run  --env-file .env -v $PROJECT_FOLDER:/.$ -it --entrypoint=/bin/bash $DOCKERIMAGE_NAME
docker run --env-file .env -v $PROJECT_FOLDER:/.$ $DOCKERIMAGE_NAME
