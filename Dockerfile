FROM haproxytech/haproxy-alpine:latest

LABEL maintainer="projetos@franciscomont.com.br"
ENV USERNAME torpool

RUN apk update && \
    apk add --no-cache tor bash python3 privoxy procps py3-pip && \
    pip install jinja2 && \
    rm -rf /var/cache/apk/*

RUN adduser -D $USERNAME

RUN mkdir -p /var/lib/tor/
RUN mkdir -p /var/run/tor/
RUN chown ${USERNAME}:${USERNAME} -R /var/lib/
RUN chown ${USERNAME}:${USERNAME} -R /var/run/
RUN chown ${USERNAME}:${USERNAME} -R /etc/privoxy

COPY start.py ./
COPY haproxy.conf /etc/haproxy.conf
COPY haproxy_username /run/secrets/haproxy_username
COPY haproxy_password /run/secrets/haproxy_password
RUN chown ${USERNAME}:${USERNAME} -R /etc/haproxy.conf
RUN chown ${USERNAME}:${USERNAME} -R /run/secrets/haproxy_username
RUN chown ${USERNAME}:${USERNAME} -R /run/secrets/haproxy_password

USER ${USERNAME}
ENTRYPOINT [ "python3", "start.py"]
