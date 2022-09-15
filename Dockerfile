# syntax=docker/dockerfile:1
FROM python:3

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN groupadd deaconn
RUN useradd -md /deaconn -s /bin/bash -g deaconn deaconn

WORKDIR /deaconn

# Create directories
RUN mkdir data-web/ && chown -R deaconn:deaconn data-web/
RUN mkdir media/ && chown -R deaconn:deaconn media/
RUN mkdir static/ && chown -R deaconn:deaconn static/
RUN mkdir back-bone/ && chown -R deaconn:deaconn back-bone/

USER deaconn
COPY requirements.txt /deaconn
RUN pip install -r requirements.txt --no-warn-script-location

COPY start.sh /deaconn/start.sh

USER root
RUN chown -R deaconn:deaconn /deaconn

USER deaconn
RUN chmod +x start.sh

VOLUME /deaconn/.local/