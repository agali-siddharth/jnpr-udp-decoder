i=0

rm -f udp_decoded_raw.txt
rm -f udp_decoded.txt

while IFS= read -r line; do

    ((i=i+1))

    ret=`echo $line | xxd -r -p | protoc --decode_raw`
    if [ $? -ne 0 ]
    then
	    continue
    fi
    echo $line | xxd -r -p | protoc --decode_raw > tmp.txt
    echo $line | xxd -r -p | protoc --decode_raw >> decoded_raw.txt
    # For Juniper Networks, the IANA assigned identifier is 2636
    # 2636 is the identifier for Juniper -
    # telemetry_top.proto:    optional JuniperNetworksSensors juniperNetworks = 2636;
    x=`grep -A1 "2636 {" tmp.txt | grep -v "2636 {" | awk '{print $1}'`
    # when using -A with grep, the lines after the match have an extra '-' at the end
    # example -
    # vrrpd_oc.proto:extend JuniperNetworksSensors {
    # vrrpd_oc.proto-   optional interfaces_vrrp jnpr_interfaces_vrrp_ext = 71;
    # vrrpd_oc.proto-}

    proto_file_1=`grep -A1 JuniperNetworksSensors *.proto | grep "= $x;" | awk '{print $1}'`
    # remove the last character
    proto_file=${proto_file_1%?}
    if [ -z "$proto_file" ]
    then
	    continue
    fi
    echo $line | xxd -r -p | protoc --decode TelemetryStream $proto_file -I /usr/include/ -I .  >> decoded.txt

done < $1

rm -f tmp.txt

