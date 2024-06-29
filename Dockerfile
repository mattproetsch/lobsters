FROM ruby:3.3.1

USER root
RUN apt update \
 && apt upgrade -y \
 && apt install -y nodejs sudo \
 && apt clean -y
 
RUN useradd -m user \
 && echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
 && mkdir -p /opt/app \
 && chown -R user:user /opt/app

USER user

WORKDIR /opt/app

RUN git clone https://github.com/lobsters/lobsters.git \
 && cd lobsters \
 && git checkout 32930ab

WORKDIR /opt/app/lobsters

RUN bundle install
