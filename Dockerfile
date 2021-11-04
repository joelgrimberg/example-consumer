FROM pactfoundation/pact-cli


ENV PACT_BROKER_BASE_URL='https://joelgrimberg.pactflow.io'
ENV REACT_APP_API_BASE_URL='http://localhost:8080'

RUN apk add --no-cache --virtual build-dependencies build-base

RUN  apk --no-cache add ca-certificates wget bash nodejs \
  && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
  && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk \
  && apk add glibc-2.29-r0.apk

RUN apk -Uuv add --no-cache make curl groff less
RUN apk update
RUN apk upgrade
RUN apk add --update npm

WORKDIR /app

COPY package.json /app/
RUN npm install
COPY . /app/

RUN make test
