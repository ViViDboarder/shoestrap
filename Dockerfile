FROM ubuntu:hirsute

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
        apt-get install -y --no-install-recommends sudo

RUN useradd -m vividboarder
RUN echo "vividboarder:vividboarder" | chpasswd
RUN adduser vividboarder sudo

VOLUME /home/vividboarder
ENV HOME /home/vividboarder

RUN mkdir /shoestrap
WORKDIR /shoestrap
COPY ./helpers ./helpers
COPY ./ansible-cookbook ./

RUN mkdir -p ./recipes/default ./assets/default
COPY ./recipes/default/packages ./recipes/default/
RUN ./ansible-cookbook default packages

COPY ./recipes/default/vim-settings ./recipes/default/
RUN ./ansible-cookbook default vim-settings

COPY . .
RUN ./ansible-cookbook default dotfiles
RUN ./ansible-cookbook default bin
RUN ./ansible-cookbook default fish
RUN ./ansible-cookbook default git

RUN chown -R vividboarder:vividboarder /home/vividboarder
USER vividboarder
WORKDIR /home/vividboarder
