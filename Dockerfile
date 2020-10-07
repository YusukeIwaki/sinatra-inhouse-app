FROM ruby:2.7-alpine

RUN apk add --no-cache \
    build-base \
    less \
    postgresql-dev
