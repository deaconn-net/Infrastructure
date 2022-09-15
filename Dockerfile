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

RUN mkdir data/
RUN mkdir data-web/
RUN mkdir media/
RUN mkdir static/
RUN mkdir back-bone/

COPY start.sh /deaconn/start.sh

USER root
RUN chown -R deaconn:deaconn /deaconn

USER deaconn
RUN chmod +x start.sh

VOLUME /deaconn/.local/