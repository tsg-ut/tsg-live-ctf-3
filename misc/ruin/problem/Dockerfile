FROM rust:1.31

RUN apt-get update && \
        apt-get -y upgrade && \
        apt-get install -y \
            xinetd \
            iproute2 \
            nodejs \
            nodejs-dev \
            node-gyp \
            libssl1.0-dev \
            npm \
            python3 \
            bc && \
        npm install -g proof-of-work


RUN groupadd -r user && useradd -r -g user user

COPY --chown=root:root ./build/ctf.conf /etc/xinetd.d/ctf
COPY --chown=root:user ./build/flag /home/user/flag
COPY --chown=root:user ./build/start.sh /home/user/start.sh
COPY --chown=root:user ./problem/run.py /home/user/run.py

WORKDIR /home/user

RUN chmod 444 /etc/xinetd.d/ctf && \
    chmod 444 flag && \
    chmod 555 ./start.py && \
    chmod 555 ./start.sh && \

USER user
EXPOSE 31000

CMD ["xinetd", "-dontfork"]

