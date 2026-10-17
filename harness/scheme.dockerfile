FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

# The project root is bind-mounted at /app at run time, so nothing is copied into the image
RUN apt-get update && apt-get install -y chicken-bin=5.3.0-2build1
