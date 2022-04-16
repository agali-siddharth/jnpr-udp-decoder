FROM alpine:3.15

RUN apk add --no-cache bash git tshark protobuf-dev xxd

RUN git config --global http.sslverify false &&\
    git clone https://github.com/agali-siddharth/jnpr-udp-decoder.git &&\
    cd jnpr-udp-decoder && git checkout 01a4665e66e7c2e20e5db673013bbd398367a395

WORKDIR /jnpr-udp-decoder

RUN cp entrypoint.sh generate_udp_output.sh udp_decoder.sh /usr/local/bin/

WORKDIR /usr/local/bin

RUN chmod +x entrypoint.sh generate_udp_output.sh udp_decoder.sh

WORKDIR /protos

ENTRYPOINT ["entrypoint.sh"]

CMD ["default"]
