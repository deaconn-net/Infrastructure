# syntax=docker/dockerfile:1
FROM python:3

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /deaconn

COPY requirements.txt /deaconn
RUN pip install -r requirements.txt

COPY . /deaconn
COPY bg.mp4 /deaconn/back-bone/deaconn/home/static/home/bg.mp4
