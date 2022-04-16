#!/bin/sh

set -e

if [ -z $1 ];
then
file="target.pcap"
else
file=$1
fi

tshark -r $file -Y "udp" -T fields -e data > tshark_data.txt

bash /jnpr-udp-decoder/udp_decoder.sh tshark_data.txt
