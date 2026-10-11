FROM ubuntu:26.04

ARG FOLDER_NAME
ARG SCHEMA_FILE

ENV DEBIAN_FRONTEND=noninteractive

COPY ${FOLDER_NAME}/${SCHEME_FILE} /app/${FOLDER_NAME}/${SCHEME_FILE}

RUN apt-get update && apt-get install -y chicken-bin=6.0.0
