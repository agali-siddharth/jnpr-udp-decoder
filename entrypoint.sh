#!/bin/sh

set -e

if [ "$1" = 'default' ]; then
echo "Running default"
exec generate_udp_output.sh $2
else
echo "Running user supplied arg"
exec "$@"
fi
