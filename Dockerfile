FROM alpine:3.15.0

RUN apk add bash git tshark protobuf-dev xxd

RUN git config --global http.sslverify false &&\
    git clone https://github.com/agali-siddharth/jnpr-udp-decoder.git &&\
    cd jnpr-udp-decoder && git checkout a11867bbe126a2b211f568a14016705aa76fc89a

WORKDIR /protos

RUN cp /jnpr-udp-decoder/entrypoint.sh /jnpr-udp-decoder/generate_udp_output.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/generate_udp_output.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["default"]
