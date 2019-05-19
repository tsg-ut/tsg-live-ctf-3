FROM rust:1.31

RUN apt-get update && \
        apt-get -y upgrade && \
        apt-get install -y \
            xinetd \
            iproute2 \
            libssl1.0-dev \
            python3 \
            bc && \
        curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
        apt-get install -y nodejs && \
        npm install -g proof-of-work

RUN groupadd -r user && useradd -r -g user user -d /home/user

COPY --chown=root:root ./build/ctf.conf /etc/xinetd.d/ctf
COPY --chown=root:user ./build/flag.py /home/user/flag.py
COPY --chown=root:user ./build/start.sh /home/user/start.sh
COPY --chown=root:user ./problem/run.py /home/user/run.py

WORKDIR /home/user

RUN chmod 444 /etc/xinetd.d/ctf && \
    chmod 444 flag.py && \
    chmod 555 ./run.py && \
    chmod 555 ./start.sh

USER user
EXPOSE 37000

CMD ["xinetd", "-dontfork"]
