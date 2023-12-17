FROM ubuntu:jammy


ARG DEBIAN_FRONTEND=noninteractive 
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y python3-pip python3-dev && \
    apt-get install -y software-properties-common && \
    apt-get install -y ansible && \
    apt-get install -y git


RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install -y neovim
RUN apt-get install -y python3-neovim
