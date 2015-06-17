#!/bin/bash

# parse options
OPTIND=1         # Reset in case getopts has been used previously in the shell.
site="bykrista"
preview=0;

function show_help {
    echo -n "usage: ";
    echo -n $(basename $0);
    echo " [-p] [-s <site>] [-h|-?]";
    true;
}

while getopts "h?ps:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    p)  preview=1
        ;;
    s)  site=$OPTARG
        ;;
    esac
done


# run zucchini
zucchini --config=/home/chisel/development/docker-bykrista/zucchini.conf

# build new container
_timestamp=$(date +%Y%m%d.%H%M%S)
docker build -t chizcw/bykrista:${_timestamp} /home/chisel/development/docker-bykrista/

exit;

# stop any existing bykrista-preview containers
_cid=$(docker ps --no-trunc |grep "bykrista_[0-9]" |awk '{print $1}')
if [ -n "$_cid" ]; then
    echo "stopping active container: $_cid";
    docker stop $_cid;
else
    echo "no active containers running; nothing to stop";
fi

# start new container
docker run \
    --detach=true \
    --name=bykrista_${_timestamp} \
    -e VIRTUAL_HOST=preview.bykrista.co.uk \
    -t chizcw/bykrista:${_timestamp}
