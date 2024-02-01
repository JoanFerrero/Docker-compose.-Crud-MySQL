# Install dependencies
FROM node:19-alpine as install
WORKDIR /usr/src/app
COPY package.json .
RUN npm install

# Start application
FROM node:19-alpine as start
WORKDIR /usr/src/app
RUN apk update && apk add bash
RUN npm install npm@latest
COPY package.json .
COPY wait-for-it.sh .
RUN chmod +x wait-for-it.sh
COPY --from=install /usr/src/app/node_modules ./node_modules
COPY src ./src
EXPOSE 3000