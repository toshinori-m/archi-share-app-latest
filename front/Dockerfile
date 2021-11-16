FROM --platform=linux/x86_64 node:14.17-alpine3.14

ENV HOME="/app" \
    HOST=0.0.0.0 \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

WORKDIR ${HOME}

COPY package*.json ./
COPY yarn.lock ./

RUN apk update && \
    apk upgrade && \
    npm install -g n && \
    yarn install &&\
    rm -rf /var/cache/apk/*