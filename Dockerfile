FROM ghcr.io/gohugoio/hugo:v0.162.1 as hugo

FROM docker.io/node:24.16.0-alpine

RUN apk add --no-cache chromium ttf-freefont poppler-utils && npm install puppeteer-core