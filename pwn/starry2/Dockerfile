FROM golang:1.12.5

RUN apt-get update && \
        apt-get -y upgrade && \
        apt-get install -y \
            xinetd \
            iproute2

RUN groupadd -r user && useradd -r -g user user

COPY --chown=root:root ./build/ctf.conf /etc/xinetd.d/ctf
COPY --chown=root:user ./build/start.sh /home/user/start.sh
COPY --chown=root:user ./writeup/starry.go /home/user/starry.go


WORKDIR /home/user

RUN go build && mv user starry

RUN chmod 444 /etc/xinetd.d/ctf && \
    chmod 555 ./start.sh

USER user
EXPOSE 36000

CMD ["xinetd", "-dontfork"]
