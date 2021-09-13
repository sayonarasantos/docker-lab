FROM node:alpine

RUN mkdir /project \
    && chown node:node -R /project
USER node
WORKDIR /project

COPY --chown=node:node . .

RUN yarn install --frozen-lockfile \
    && yarn build:prod \
    && yarn cache clean

EXPOSE 3000

CMD [ "node", "./dist/src/main.js" ]
