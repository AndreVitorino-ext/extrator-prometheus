#!/bin/bash

EVENT_DIR="$(dirname $0)/sphinx"
DOCKERIMAGE_NAME=publish-confluence
DOCKERIMAGE_PATH="$(dirname $0)/sphinx"
FORCEDBUILD=false

# Execute only on GIT pre-commit
if ! [ "$GIT_HOOK_EVENT" = "pre-commit" ]; then exit 0; fi

# Redirect output to stderr.
exec 1>&2

# If has modified entrypoint or Dockerfile, rebuild image.
if [ "$(docker images -q $DOCKERIMAGE_NAME 2> /dev/null)" == "" ]; then
	FORCEDBUILD=true
else
	for item in $(git diff --name-status | cut -f 2 ); do
		if 
			[[ "$EVENT_DIR/entrypoint" == *"$item" ]] || \
			[[ "$EVENT_DIR/Dockerfile" == *"$item" ]]
		then
			FORCEDBUILD=true
		fi
	done
fi

if [ "$FORCEDBUILD" = true ]; then
	docker build $DOCKERIMAGE_PATH -t $DOCKERIMAGE_NAME
fi
