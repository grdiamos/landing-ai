# Base container name
ARG BASE_NAME=python:3.9

FROM $BASE_NAME as base

# Package name
ARG PACKAGE_NAME=landing-ai

# Install python packages
WORKDIR /app/$PACKAGE_NAME

COPY requirements.txt /app/$PACKAGE_NAME/requirements.txt

RUN apt-get update -yqq \
    && pip install -r requirements.txt \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

# Install code
COPY . /app/$PACKAGE_NAME

RUN chmod +x /app/$PACKAGE_NAME/scripts/start.sh

ENV PACKAGE_NAME=$PACKAGE_NAME
ENTRYPOINT /app/${PACKAGE_NAME}/scripts/start.sh

