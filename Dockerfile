# syntax=docker/dockerfile:1
FROM python:3

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN groupadd deaconn
RUN useradd -md /deaconn -s /bin/bash -g deaconn deaconn

WORKDIR /deaconn

USER deaconn
COPY requirements.txt /deaconn
RUN pip install -r requirements.txt

COPY bg.mp4 /deaconn/back-bone/deaconn/home/static/home/bg.mp4
COPY deakey /deaconn/.ssh/id_ed25519
RUN mkdir data/

COPY start.sh /deaconn/start.sh

USER root
RUN chown -R deaconn:deaconn /deaconn
RUN chmod 700 /deaconn/.ssh && chmod 600 /deaconn/.ssh/id_ed25519

USER deaconn
RUN chmod +x start.sh

VOLUME /deaconn/.local/
VOLUME /deaconn/.ssh/
