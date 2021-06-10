#! /bin/bash

image_name=devenv-$(whoami)
container_name=$image_name-run

if ! docker inspect "$container_name" > /dev/null ; then
    echo "start new"
    docker run -it \
        --hostname="$(hostname)-docker" \
        --env SSH_CLIENT=true \
        --env TERM_PROGRAM="$TERM_PROGRAM" \
        --env ITERM_PROFILE="$ITERM_PROFILE" \
        --volume /:/host \
        --name "$container_name" \
        "$image_name" fish
else
    echo "start existing"
    docker start --attach --interactive "$container_name"
fi
