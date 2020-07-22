FROM python:3.7-alpine

# Add project source
WORKDIR /usr/src/musicbot
COPY . ./

# Install dependencies
RUN apk update \
&& apk add --no-cache \
  ca-certificates \
  ffmpeg \
  opus-dev \
  libffi-dev \
  libsodium-dev \
\
# Install build dependencies
&& apk add --no-cache --virtual .build-deps \
  build-base \
  gcc \
  git \
  make \
  musl-dev \
\
# Install pip dependencies
&& pip3 install --no-cache-dir -U -r requirements.txt \
\
# Clean up build dependencies
&& apk del .build-deps

ENV APP_ENV=docker

ENTRYPOINT ["python3", "dockerentry.py"]
