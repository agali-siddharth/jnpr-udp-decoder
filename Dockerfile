FROM alpine:3.15

RUN apk add bash git tshark protobuf-dev xxd

RUN git config --global http.sslverify false &&\
    git clone https://github.com/agali-siddharth/jnpr-udp-decoder.git &&\
    cd jnpr-udp-decoder && git checkout 01a4665e66e7c2e20e5db673013bbd398367a395

WORKDIR /protos

RUN cp /jnpr-udp-decoder/entrypoint.sh /jnpr-udp-decoder/generate_udp_output.sh /jnpr-udp-decoder/udp_decoder.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/generate_udp_output.sh

RUN chmod +x /usr/local/bin/udp_decoder.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["default"]
