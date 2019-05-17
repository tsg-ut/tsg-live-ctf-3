FROM moratorium08/ocaml-box

RUN apt-get update && \
        apt-get -y upgrade && \
        apt-get install -y \
            xinetd \
            iproute2

RUN groupadd -r user && useradd -r -g user user

WORKDIR /home/user

COPY --chown=root:user ./problem/start.sh /home/user/start.sh
COPY --chown=root:user ./build/flag /home/user/flag
COPY --chown=root:root ./build/ctf.conf /etc/xinetd.d/ctf

RUN chmod 444 /etc/xinetd.d/ctf && \
    chmod 444 flag && \
    chmod 555 ./start.sh

USER user
EXPOSE 33000

CMD ["xinetd", "-dontfork"]
