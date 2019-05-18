FROM python:3.6

RUN pip install flask

RUN groupadd -r user && useradd -r -g user user

COPY --chown=root:user ./build/flag /home/user/flag
COPY --chown=root:user ./problem/websh.py /home/user/websh.py
COPY --chown=root:user ./problem/index.html /home/user/index.html

WORKDIR /home/user

RUN chmod 444 flag && \
    chmod 444 index.html && \
    chmod 555 ./websh.py

USER user
EXPOSE 32000
ENV FLASK_APP ./websh.py

CMD flask run -h 0.0.0.0 -p 32000
