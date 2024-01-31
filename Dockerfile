FROM node:16-alpine as build

RUN apk add --no-cache git python3 gcc make g++

RUN mkdir /home/node/app

WORKDIR /home/node/app

COPY . .

RUN yarn global add node-gyp && yarn && yarn build

FROM node:16-alpine

RUN npm install serve -g

RUN mkdir /home/node/app

WORKDIR /home/node/app

COPY --from=build /home/node/app/build/ ./

CMD [ "serve", "-s", "." ]